Return-Path: <linux-kernel+bounces-728732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E378B02C5C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 20:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA903B1BFD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E795183CB0;
	Sat, 12 Jul 2025 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3IEEwWk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5361531C8
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344260; cv=none; b=PI+yXJFrDeRmEStrMSxAFBHQMGNgypozE8kgXWlQR/6ps2v0Qo+jOujPVCN89hMJwFG/tBjnKmbRaqpvDviEqx17U850YaNNtZi7U/0To5+FHcHY7T+nxGZ4NnlvR0O/G8wM5uJ+cNDtzaCsH/WDPagD4ecGWwjK9YeGP6FVdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344260; c=relaxed/simple;
	bh=kIliXIGbbOAwz7c7KDqlBexZvwRzkL5Gek8IUWY3F5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yj2EXUyBSkY6pvIlhRtJfwunnteLpWloz253cJ0NDGUtO2SGgL9huYH0+6p5Kx4EpM909ZBYI1GoCWmSloviT8UQg3OOyl2a/O1/dFcDym4PappxYCOUAp3udiyN0h/kxFzjp/8gFt7OOFKdtNohMPmWl231ecuD4MNKO+WCyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3IEEwWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272BBC4CEEF;
	Sat, 12 Jul 2025 18:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344259;
	bh=kIliXIGbbOAwz7c7KDqlBexZvwRzkL5Gek8IUWY3F5E=;
	h=From:To:Cc:Subject:Date:From;
	b=B3IEEwWkAO/MqxRvtFzpBneYPj4IOp9K6DNMzitg3RfOyujifXFdoEgSw+t/1XKa9
	 rCVzKaD+v90teHiXoVqMk1UbdyBPaM4XCFE9sdbt0UdJGg+cJNEKZHAQVhdNSgUvD2
	 blkHVlQYW9gyaNB2f0qDVnnes/XVlvzzR3nVJPcGSNU+C80eBYr4YgmIjadhx64r+a
	 KBOpRVCXM6f11PARp9rB4YGQ8Xz6GsgQ9CkccY2tFsQJ3FQO/INMB1vd5dZNhD61u1
	 Xva5ohdPnTElxjaDLtFBJUDLNaQyKVxh/TVztqQLCuA/hjN/w1Wa6O+iG6I+c3K16r
	 h/rG3GSzZO81w==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 0/2] nvmem: fixes for 6.16
Date: Sat, 12 Jul 2025 19:17:25 +0100
Message-ID: <20250712181729.6495-1-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srini@kernel.org>

Hi Greg, 
Here are two nvmem fixes for 6.16, Could you queue
these for 6.16

Fixes include:
	- crc32 endianness conversion in u-boot-env
	- fix the mac address length in imx-ocotp provider

thanks,
Srini
.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Michael C. Pratt (1):
  nvmem: layouts: u-boot-env: remove crc32 endianness conversion

Steffen Bätz (1):
  nvmem: imx-ocotp: fix MAC address byte length

 drivers/nvmem/imx-ocotp-ele.c      | 5 ++++-
 drivers/nvmem/imx-ocotp.c          | 5 ++++-
 drivers/nvmem/layouts/u-boot-env.c | 6 +++---
 3 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.43.0


