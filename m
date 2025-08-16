Return-Path: <linux-kernel+bounces-771829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7E4B28BFE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CEE1CE47AA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519D02367D9;
	Sat, 16 Aug 2025 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="h8LsyQDU"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4B1E25E3;
	Sat, 16 Aug 2025 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755333918; cv=pass; b=dqyfXxCoA6OLiTGbX3M7cPTjmOfNowmRPI+8yUG8mafOrrgs1ROtq0quQweUW5R66N6h+9vtxZ84+fUaP1DP/u6Y+6xUmO3PJ50RZ1M0jHTHH6Ng3TRRe0bJ99YF5R2IbBewS18Y1FJzkQH8FVxi2vnP1g2vcATehxWtux3oQLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755333918; c=relaxed/simple;
	bh=IIvF7ER386wXjV9EF114X6Z87pnaDPFbNrWuq/ZdIDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnfZgmHImFdUlyAgBVQ5of8mgcoCUfFDp7SoBP8pKtZ5+H3Mdvz1msIMWJhjVdMRvMwu1Bllo7fhEv/ZHufn6jyIThjsyDq7ehhv9rsgSAlYzvgEvm9jO2WPpbjziYNSLdNEic5RNR7U/N4mPwG48PKNZVu6QuVBrskQZhe/Ebw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=h8LsyQDU; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755333900; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XXAOpm4rWcwReFuaQKg8NtDfyw9w0XiWY97NzK9aEVZNVR9yY7HjywXrU01faseUSyW+KHmdu/W02qA1ct5l4wEt0rhz2auhUmfqF6VUvo9ei80EiU2cSiCvKEKWelDNeSIp44ACdOR4LZ66VX63glUhVRxXplwORYPgKeLDgIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755333900; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t773CWX/vAKNBpBvue1w4mNog/qC2XeO74irT/8/hA8=; 
	b=E5Iz9hCkG8mIw5NiziigRQmlZhtdyRVckSUJisQSr0byLOFU6T6n/GMBs3HoSLHVotP5TRVs2I9FzPWNtllUv5du3FO5bzR49vp+f2f0ikf8HIALdNBOu3VJVdZnwu+J713yKCR4imZ2BCEzHb+3VivFcZmRrfH6i02GPfDrxjs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755333900;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=t773CWX/vAKNBpBvue1w4mNog/qC2XeO74irT/8/hA8=;
	b=h8LsyQDUj1El7T8Y+CXCrE7pWurCEfJs2TeH0i8xVBnsvceCk2rhZVAriI2ra+N9
	NkTYK/7bJATOODYZOEp24oOoolSPi3h2sBRuWm1SmklOOVD5vcn5ki8cq+VCATr/Ws6
	myFIi0uthjt3WlX9bNPNuP/+LYipxXlHJpZqdZUglkcJFnMo6C7JNZwzejxkjkmJ24B
	Cx1yn6QwXmd5UQlwRmzRAVXqHn/3ox9sN2Ke6+tJYBZN1gU1nHSiHdwj5EQaPhabNQV
	aSXJEoiw/hiHG6tTE67SUIv/y4aH9+mjsRM3GP9JG+cXaKsOAlTvZLai5dv90s5rmae
	ooQaAsqoCw==
Received: by mx.zohomail.com with SMTPS id 1755333898289307.1686031953286;
	Sat, 16 Aug 2025 01:44:58 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 0/2] clk: thead: th1520-ap: allow gate cascade and fix padctrl0
Date: Sat, 16 Aug 2025 16:44:43 +0800
Message-ID: <20250816084445.2582692-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Current ccu_gate implementation does not easily allow gates to be clock
parents because of the waste of struct clk_hw in struct ccu_gate;
however it's found that the padctrl0 apb clock gate seems to be
downstream of perisys-apb4-hclk, gating the latter w/o gating the former
makes the padctrl0 registers inaccessible too.

Fix this by refactor ccu_gate code, mimicing what Yao Zi did on
ccu_mux; and then assign perisys-apb4-hclk as parent of padctrl0 bus
gate.

Icenowy Zheng (2):
  clk: thead: th1520-ap: describe gate clocks with clk_gate
  clk: thead: th1520-ap: fix parent of padctrl0 clock

 drivers/clk/thead/clk-th1520-ap.c | 386 +++++++++++++++---------------
 1 file changed, 189 insertions(+), 197 deletions(-)

-- 
2.50.1


