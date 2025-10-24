Return-Path: <linux-kernel+bounces-867928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0A0C03F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60D793598CD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8967515530C;
	Fri, 24 Oct 2025 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="SSC63Opn"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00BF78F51
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265200; cv=none; b=Und5f9CP0EbLz0We3M6BonIq6FbdyZ8O7Vi82wExWUrK6yZwu1AGj20piVfJU7530ckOvXljdATcGjF35eicgbfLlpUlQbLGZjMgzGSJB9XY8ll/xgOvZSb4xW/gryHMp8f/k33AS51P16Dkk+WdDiLJxAoSYMT6Hfu5E/ylW6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265200; c=relaxed/simple;
	bh=l7NcD7fnH4/8OxxlQYYXSK5FoVtW3uUClBL/MB/vjh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiAhkxNy7YXrGdLQ5P2AZqxNEEyQ8LF0UajbsOYYQ1XzmXGazOPc2z48OplE6LQILQf3DB9sic3yf6nqu11jk2s/Z5s+VaA4x8TaM0hE09bq2U4yG0rNGDkK/RDNBkuBhMd5xqhAnmCTyM0pwuvFGvphp1Mc1gl5BvG1TtraS4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=SSC63Opn; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0E7382C01FD;
	Fri, 24 Oct 2025 13:19:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1761265189;
	bh=ZupoVAigkdpoTMBJ+8X5ukJ5HKFW2qvccHluhJLygIE=;
	h=From:To:Cc:Subject:Date:From;
	b=SSC63OpnVhGVbHuEf7m5IJWMni2as0eUyVNSEuq+EHCWJUvSn56eqH2i1NXUbC3cc
	 fhAB5qCj7i0B05PcUZldExThV/Js9K+Bz4APGwawEZieRqtHUVV58Y+P026zHvAlOa
	 Y8ivkAiphXfVVOMuIkwO1htsx0O5CG/2Rdc0TA9ZfDBGkDmu9QPx0O6ceRjKoJT1xz
	 iGH6FUaf1nt1HfXgoKPjkCG+Uk0+nBfREyqIOW1IA19ZpuW9D2eUJB06zj1XvmmefN
	 MpPBBxcVyuuKP8f5F8FF0PmBspfGuF6htQ3pi5hmqTC7+5t9qMRf3jTIGlLp+nsSyE
	 FdQ8ulfPbm5iw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68fac6240000>; Fri, 24 Oct 2025 13:19:48 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.12.16])
	by pat.atlnz.lc (Postfix) with ESMTP id C40E913ED0C;
	Fri, 24 Oct 2025 13:19:48 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id C23512A0433; Fri, 24 Oct 2025 13:19:48 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Subject: [PATCH v0 0/2] mtd: nand: allow unconventional NAND layouts
Date: Fri, 24 Oct 2025 13:19:40 +1300
Message-ID: <20251024001943.29557-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=NbFF1HD4 c=1 sm=1 tr=0 ts=68fac624 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=x6icFKpwvdMA:10 a=E9JnvtB01pNfywlg1hkA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Currently validity checks in nand_scan_tail only allow NAND layouts with
evenly sized chunks. This results in controllers which use
unconventional layouts to fail these checks. To pass these checks
the marvell_nand driver would incorrectly read pages (leaving out the
unevenly sized chunk).

Relax this check and remove the change which modifies the layouts
resulting in errounous read/writes.

Aryan Srivastava (2):
  Revert "mtd: rawnand: marvell: fix layouts"
  mtd: nand: relax ECC parameter validation check

 drivers/mtd/nand/raw/marvell_nand.c | 13 ++++++++-----
 drivers/mtd/nand/raw/nand_base.c    | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

--=20
2.51.0


