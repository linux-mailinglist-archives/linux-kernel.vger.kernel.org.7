Return-Path: <linux-kernel+bounces-742190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964A2B0EE83
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB25172477
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7B32836A3;
	Wed, 23 Jul 2025 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdIeza0Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C27273D6A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263214; cv=none; b=T8mYPBjftKmcqIbmlGKk80MBUTL/Vc6mBRpPgOfrMTQohMaVzkGoB+YI77nAadG9n08TmYCnHpzpKLcEBp0W2ZB0aJFH/3Jb03u+EVHNtzvP6JInjvadodIF2/NkJfBBWxST6zaFOiw5Whsz9XLIKx59c420W13EpQyiq/tKGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263214; c=relaxed/simple;
	bh=KBxipLHtpbufm4Kck6q9H41Sj+h8LM46+hXw0o6aGKA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nDP5RJjrTRxd0mpxCuKYQVf5a70WU429efxwJvVZmjmrQzT7Y2FQ7bqyQ6spNPTDKH7SW7Or5cZO0+mC1JZ5byz4RfqvZFWO3v5teP2B0IKlcrgosvocRx/qJFh9WhcPSVVJMEdPGjGFbQ/rlqT9KP+CflhuweGxwmfYm4J7tUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdIeza0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B4DC4CEE7;
	Wed, 23 Jul 2025 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753263214;
	bh=KBxipLHtpbufm4Kck6q9H41Sj+h8LM46+hXw0o6aGKA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NdIeza0QrJG16/Lva8+/ql6lOB8euYZq9XwA39UNXqbFPtC1VsS/koV/ftkKNNJl6
	 tYE3NucrmnI5T28lFJuNp/yEOzbbD088TZsmMPvC+E8xYX366Dn47wQvzo1kUx0pQn
	 37ibQ/QmSkoKv/GifZp+RFg7Ry0hdCOM1PFFKvupUsSP7DWr3NXE7ZwogoZWUMesx/
	 k+GxUqJO3T8gSRhfPqn+kT78199er7wAoXZOBRumoF60IhxZZN0I2g46AvM18jdXld
	 NaL49WZHhcVIhu8skCPWufGxnPgFbT3DmPjm7L7ZgTQaVWpv/IlKMNc4iYWJw1L1Ap
	 ZC1TFW21UbyBw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patrick.rudolph@9elements.com, naresh.solanki@9elements.com, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20250709133103.3482015-1-ckeepax@opensource.cirrus.com>
References: <20250709133103.3482015-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH] mfd: Minor Cirrus/Maxim Kconfig order fixes
Message-Id: <175326321288.1724652.16184140808221299597.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 10:33:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Wed, 09 Jul 2025 14:31:03 +0100, Charles Keepax wrote:
> Move some Cirrus parts so they are grouped together alphabetically in
> menuconfig. Also move the Maxim 5970 out of the middle of the Cirrus
> parts and put it with the other Maxim parts. No functional changes
> just alphabetising.
> 
> 

Applied, thanks!

[1/1] mfd: Minor Cirrus/Maxim Kconfig order fixes
      commit: 0937f646f71d23db3ad34804c67cb61772a4af9e

--
Lee Jones [李琼斯]


