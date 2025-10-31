Return-Path: <linux-kernel+bounces-879509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5E8C23465
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC31C1A27E72
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4382D0C70;
	Fri, 31 Oct 2025 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="PzPRPL23"
Received: from mail-m49248.qiye.163.com (mail-m49248.qiye.163.com [45.254.49.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567334D3B1;
	Fri, 31 Oct 2025 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761886413; cv=none; b=TMVfaaZ3vzuK8iV8oxHaiBzguIfITzBH2+ihzgi9h9qUw8eMoUSNci7/JdDHISq+mZM1WH8v8a7G039ZXRq36pkc+iOy8iBbKP6dsM2BW9aA8WONBDyndW0yuUi/u5F7WWM+iUlRpVCFKcHpJITq9m3+l59B0yeCRKtlOOmzHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761886413; c=relaxed/simple;
	bh=9D7MMPkSZhjVq6hlRBDYzlOjp+CnuCQUDvEFL+xDQDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTClg2bLi2indiVv+L9WlAyYH2+5RYZqjZOHkhlFaw8E1OZkFl9G+6u9CF5ukFMWwikYIrtcq4/Btecc4tX7baroXeErmQ8J4gSRB7ipExXBpQ5+O7NDC0XPhws0plTW+BBTlHyz/J9gqvstuv6mNOUFsW0LZaVvu7pQxGXxuxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=PzPRPL23; arc=none smtp.client-ip=45.254.49.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 27deeccb5;
	Fri, 31 Oct 2025 12:38:04 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzysztof.kozlowski@linaro.org
Cc: arnd@arndb.de,
	bst-upstream@bstai.top,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gordon.ge@bst.ai,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	will@kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH v5 0/6] arm64: introduce Black Sesame Technologies C1200 SoC and CDCU1.0 board
Date: Fri, 31 Oct 2025 12:38:03 +0800
Message-ID: <20251031043803.781326-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ad1bb032-6d58-435b-b2bc-04aa26d41d58@linaro.org>
References: <ad1bb032-6d58-435b-b2bc-04aa26d41d58@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a388ef3c409cckunm404592c761173f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTx8dVhhKTktMGEhOQkkeSlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PzPRPL2310JdW9Re2Ybec0cHbMyoSiSGnUFWbjShL8juQ+2rLnAysUg4vxiKlzYnnPFSIU1Cf3pMuQtwf89uvvnrQwjXuMo5UdYlbANEA72XI6xtF+GGTZoJg2fQ3E3kDLfc/PaFc5yeYASHK87cauI0n5KzVETc1gzQ7CqLZ6o=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=9D7MMPkSZhjVq6hlRBDYzlOjp+CnuCQUDvEFL+xDQDI=;
	h=date:mime-version:subject:message-id:from;

On Thu, Oct 30, 2025 at 04:04:39PM +0100, Krzysztof Kozlowski wrote:
> On 30/10/2025 12:40, Albert Yang wrote:
> > Hi Krzysztof,
> >
> > Gentle ping on this series. It's been two weeks since v5 was posted.
> >
> > This version addresses the DTS coding style and property ordering issues
> > from our previous discussion [1]. Following Arnd's suggestion [2], the MMC
> > patches have been removed and will be submitted separately.
> >
> > Patch 2/6 (arm bindings) already has your Reviewed-by. The remaining
> > patches (Kconfig, DTS, defconfig, and MAINTAINERS) are ready for review
> > when you have time.
>
> I don't understand this ping. You received the reviewed from me or other
> maintainers, where we were responsible to give such review. Probably you
> assume that my job is to review something else here, but sorry, that's
> not my job at the time of this patchset was prepared (we don't count
> here recent changes because that would mean you ping me after few days...).
>

My apologies for the confusion. You're absolutely right about the
maintainer responsibilities.

I should clarify why I pinged you: You provided valuable feedback on
earlier versions of this series, including the DTS patches. Since those
changes were made based on your input but hadn't received confirmation,
I wanted to make sure they properly addressed your concerns. However, I
now understand that the SoC-specific patches (Kconfig, DTS, defconfig,
MAINTAINERS) should be reviewed by the ARM SoC maintainers.

Thank you for your reviews and for clarifying the proper process. I'll
follow up with Arnd for the remaining patches.

Best regards,
Albert

