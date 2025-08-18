Return-Path: <linux-kernel+bounces-774215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0961B2AFFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFBC1892BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18DE32BF3C;
	Mon, 18 Aug 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpI1hpcV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906832BF27;
	Mon, 18 Aug 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540610; cv=none; b=ojtcGesAnC+VRwyaYC13Z6EFsBwwr/8ZcrZ0dmDwCGzG3RLpSKbnaVwxvZz+eGCAGOnuNppgJ6bMyKSJyZA5FGUOX+iH9ukDwtOVuqdAJL2bsA5N8UKzyBNujnnLflb41AFwOPk7z5UOr3L+vC8HK3/4tOTl8aBoofLJilni9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540610; c=relaxed/simple;
	bh=jMVvbsnf1oEQd5gkEV0n5XAZ+pjUrdjivDi621ygFWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqskFfi48TnFg/BbNNZKKFi4NTSMCHsHo4ocPWYYYGy7cG6zo7JpVyejuyYQLJxLmFHNrwOXL7Ps47oAwdOORjnBLKdtI5R8xIOYtlMdxIJz4V0uyQkCdOrmkk77hW4tYNdf6+W99kjvN6ELNTlvyyVm/9W8ubz4LVgLY/Nnyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpI1hpcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E2BC113D0;
	Mon, 18 Aug 2025 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755540609;
	bh=jMVvbsnf1oEQd5gkEV0n5XAZ+pjUrdjivDi621ygFWY=;
	h=From:To:Cc:Subject:Date:From;
	b=VpI1hpcVHz7ayIp0PvAoOVUDDUwUgKQgHjpxrq0sQCjnplZHuV2dp8YzRf78rNmoV
	 Ofh/Lcr7LB+MrTBJeqtKWyV3vXOy8lNp9uA8Dw5bDq5r8D7v4qTPaC7U9zRQIRRGf4
	 zPqgAYzEH4HGEjvRsrH/CoUxUmmqHrmvk0JGOkURamsiIHKwzfGrLRKgs7tRdPWb2a
	 Nrup4hNN4bOGBFIctdweH+2NEpnQkn6DUl5veQ19wQmjozHQd7W01KlOr6LIfz5u1I
	 JWY7IqEtBe46J86LphQq398b/ruAsj4zl1RUJJBoRoR8y6gr2o0uVa2KcMQl5L1qS6
	 ygDzQ0XNfxR+A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uo4J5-00000001sQW-1JsT;
	Mon, 18 Aug 2025 20:10:07 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	corbet@lwn.net
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 0/1] sphinx-build-wrapper: Fix a performance regression
Date: Mon, 18 Aug 2025 20:10:00 +0200
Message-ID: <cover.1755540431.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As reported by Akira, using sphinx-build-wrapper serialize PDF builds.

This patch addresses it as commented at the thread.

The patch on this series comes after:

	https://lore.kernel.org/linux-doc/cover.1755258303.git.mchehab+huawei@kernel.org/

I opted to send it in separate to avoid respining the entiire series just for
a new patch at the end.

Mauro Carvalho Chehab (1):
  scripts/sphinx-build-wrapper: allow building PDF files in parallel

 scripts/sphinx-build-wrapper | 141 ++++++++++++++++++++++++++---------
 1 file changed, 106 insertions(+), 35 deletions(-)

-- 
2.50.1



