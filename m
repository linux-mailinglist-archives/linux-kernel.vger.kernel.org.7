Return-Path: <linux-kernel+bounces-737743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E5CB0B003
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E384CAA4904
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D310828689B;
	Sat, 19 Jul 2025 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2TIAbnc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC81862A;
	Sat, 19 Jul 2025 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752929340; cv=none; b=LMPyZF5tAgOBetsGcFn0ZMyfRXWykZHvbmgSPUqM7fz38GTnmrEH+uBK49BZ2QZR3JVumwg2GDNgfu6ZsQInhrfpfOXnEruGfrzZavm1yG1Mevave9MhG7a5s6OZfeHyDIVwEdaCMlxOIHQjZEhm+Rbjz+RHl55tDxC9ieeDg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752929340; c=relaxed/simple;
	bh=5SM3JjfwPbAzhO4EKz+cDoOsvzGPzduC3NBRmt8QUZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJHT5dDVnzh7e6aJAwY5BeoehWG2rDVyG68iaro16JsL6gO+y2jVUnijDSf08B7KWSmjOKDBSc92uu+4qGgCfzZLsACu+detIaueYtwCWdlySYE6FLWMWwwj68k7CrTJonEQBfAn7UA/lFSGW42pRoj1GrTEhNn3wydqqjEULwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2TIAbnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75471C4CEE7;
	Sat, 19 Jul 2025 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752929339;
	bh=5SM3JjfwPbAzhO4EKz+cDoOsvzGPzduC3NBRmt8QUZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T2TIAbnc9yVX5tqWvu1WyvfhEBGfcitOaJBAgRSppOkNESHgPzUwuhAArFTG9UqHM
	 Mu6fDoXbtqyepEITcgChTu68lB5qs2fXx7pc9tn0/8pIEg6VjMrpO9aE+WtQZ8vgNB
	 aq6ZHW1I5UWt7p2pcTVWbpNHVW+QIebPZJ54B8mJmfJtHzikoh/3+T9jE8GmAO2N1J
	 eL+ecZb6vHpA4ZE/o3/4SVONdt7+eN8DTpuS0x4bsV+cQOgoTEgSphWGpLZo8x6TLS
	 IRk53G+3q7lRdGjPWBhmKRiyifryP46VzOZMAoRGL4LRLBcthsiuYttacgE0Nat6YK
	 b4e1mHn8o1Ocg==
From: Sven Peter <sven@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 0/2] Extend nvmem patternProperties and then fix W=1 warnings in Apple dts
Date: Sat, 19 Jul 2025 14:48:39 +0200
Message-Id: <175292930369.11148.3364795405585687646.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250610-nvmem-bit-pattern-v1-0-55ed5c1b369c@kernel.org>
References: <20250610-nvmem-bit-pattern-v1-0-55ed5c1b369c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 10 Jun 2025 17:17:33 +0000, Sven Peter wrote:
> This brief series fixes a W=1 warning recently introduced with the Apple
> Silicon PMIC NVMEM nodes. We have cells that are the same bytes but a
> different bit offset and these currently result in the same node name.
> The legcy layout already allows to specify the bit offset in the name as
> a suffix but this isn't possible in the new fixed-layout.
> Thus first adjust the fixed-layout cell patternProperties to the same pattern
> as the legacy one and then fix the node names in our device tree files.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (asahi-soc/for-next), thanks!

[2/2] arm64: dts: apple: Add bit offset to PMIC NVMEM node names
      https://github.com/AsahiLinux/linux/commit/a622259af9eb

Best regards,
-- 
Sven Peter <sven@kernel.org>


