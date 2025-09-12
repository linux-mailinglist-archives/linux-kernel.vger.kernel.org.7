Return-Path: <linux-kernel+bounces-814085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EEEB54F04
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3EE7C7DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C54130DD04;
	Fri, 12 Sep 2025 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI8Hf3Z1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBBD30DEA5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682833; cv=none; b=esJQPM8V6OuWb+VoQMcXcGVGAX4WjVmhzlJv1JgTsCpC68hNo1nIe0UuUAkNGy3JXuM2VWA8eY3F+zMKIfhEgst+aocS3vC2e26ZaYcVvGBq+i0ZjKQVCVoyAnEGs3WcpNQdBkGKqGdgzrrr27ds5NHV9N6fKGlCX+pjsKlubX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682833; c=relaxed/simple;
	bh=3C1M7FUjWchaAIWk1ONKoSDH4BGrHkWNYURUEXSXtEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pOlonpl336VXgwWt/qwcCyvOal+WHHW7qPsmVS84PNTGZTNgXCqJEaPOVEYEaeL0SpKQXPhLX/YsyDxIvaXbrubr7HGw/C25D35LYwLY8k445as0qlnyvvTmqQOS8NlH6y95swCOZSkVJB5tVhvoxORp/4aJx9rLR/rmZcNF3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI8Hf3Z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A6BC4CEF1;
	Fri, 12 Sep 2025 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682833;
	bh=3C1M7FUjWchaAIWk1ONKoSDH4BGrHkWNYURUEXSXtEs=;
	h=From:To:Cc:Subject:Date:From;
	b=MI8Hf3Z1mFlm1c/YgYqV3dk2qwSCNwDZdlGrSeLXaW734INBzOmmRdSIm9B+421/n
	 +mD2dv6IhhN/XL5loIygnej4mB8T/9S7ULwt9e660oKtTcrQoEW+6jOUS2yEvRzNuo
	 49blBf6/VU48F8QMwwdm2OA3Juwy5YdFyrTvjhj09lZZVBTBJfoYtd/SWUMQy1Hkf5
	 2MBh5avkXkMWD3D+5p6GGgrvT2HBCTZtitICt6Mj5i9qBNFFixpOsXsT4EIGn+5Dvy
	 qBadcD31fFSVQ5y5AGVCKwrWovBYW8Aa+Do2jKaQAZHs+ed1Fcx0Gr/MsdW9AAOMAj
	 PtEauLdt7zqaw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 0/1] nvmem: fixes for 6.17
Date: Fri, 12 Sep 2025 14:13:46 +0100
Message-ID: <20250912131347.303345-1-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srini@kernel.org>

Hi Greg,

Here is one nvmem fix which can go for 6.17 release
If its not too late, could you please queue these as 6.17 material.

Fix is mainly to do with module loading of layouts.

Thanks,
Srini


Michael Walle (1):
  nvmem: layouts: fix automatic module loading

 drivers/nvmem/layouts.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.50.0


