Return-Path: <linux-kernel+bounces-865837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F6FBFE238
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A911A04DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3738B2F83C9;
	Wed, 22 Oct 2025 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="liXuMCzT"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A852F549F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164312; cv=none; b=MVjly9i9L2ll0l+SRXtb8/dmFsHCKDVgj0FkJ1XkkMn/j4au9dG59jeMKNNJaK7ASORwiACTxwEnzwZW7bQlHAhrnTl2jYdWTftr+TfejhRGp2k3hLnCZXLPbFtLONRtvSC05w2957F3qLi8T+6jwS3Mb2NrpzfT4ASbKEs9gt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164312; c=relaxed/simple;
	bh=556VxUVeANKsso1HIStZpAFSR2trHjxyBLYbYMInw5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLSRoiGuiwiwQG7IxtFEbOjtIXaE6VwVEfYuXqYNoEmEYL3PBwwMGz6gyFDYl2lgm7lkouhbmxPj8m7Gbr5jxNHCsX003n10T3JVxJxmGey5IfyqED5sPS7X2akiTUlybvu9oao03xOOfEJvCqT7OfX94aiVmb7JloVdS9OKnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=liXuMCzT; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4D2B52C0982;
	Thu, 23 Oct 2025 09:18:26 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1761164306;
	bh=556VxUVeANKsso1HIStZpAFSR2trHjxyBLYbYMInw5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liXuMCzTuoOfskuyid8fD0lFErhE59qmJUVKTocIgHMV7AhdQGA4bUGQbMInQyrD2
	 XL4GR259YLNxEr7qkGNmjZ3xY/6Mkp/MR2a/W2gsR8+klT6dhz+6V8blFjGcvNIKl7
	 8erncBOjveZtw2ikAzD28/411KqQuiC2haZ2YqTQESTcATQ0eQJHAF3yCL1ppVXLoh
	 YHAUV1T0OArRz6rZUZv1qom1ujj/ywsN7UvXZL9NJ0HosUsctJiTl0Iyop94kEvkzL
	 179LhMKOoEBsGodamIk+fIP/ajE370FMLpdYwRJ3oJslyQMP3e+pH+Omjdo25m76Bc
	 2Xm3dzCfxuU9g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68f93c120000>; Thu, 23 Oct 2025 09:18:26 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.12.16])
	by pat.atlnz.lc (Postfix) with ESMTP id 2B88313ED76;
	Thu, 23 Oct 2025 09:18:26 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 2677A2A0433; Thu, 23 Oct 2025 09:18:26 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: miquel.raynal@bootlin.com
Cc: aryan.srivastava@alliedtelesis.co.nz,
	enachman@marvell.com,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	richard@nod.at,
	vigneshr@ti.com
Subject: Re: [PATCH v0] mtd: rawnand: marvell: fix 8bit ECC layouts
Date: Thu, 23 Oct 2025 09:18:25 +1300
Message-ID: <20251022201826.3164850-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87qzuvrr74.fsf@bootlin.com>
References: <87qzuvrr74.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=NbFF1HD4 c=1 sm=1 tr=0 ts=68f93c12 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=x6icFKpwvdMA:10 a=J03ggO0UBPt6F8wS28EA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Okay, I will upload a new patch series.

Thank you,
Aryan

