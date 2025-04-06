Return-Path: <linux-kernel+bounces-590072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAB6A7CE4C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 16:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42223A9887
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 14:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C408D21767A;
	Sun,  6 Apr 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b="EhkoSA5W"
Received: from wiki.archlinuxcn.org (wiki.archlinuxcn.org [104.245.9.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B2033DF;
	Sun,  6 Apr 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.9.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743948112; cv=none; b=CmHWSUSzN49LWwjj+jWnDkxYPckWo1ojFKENU8CLyRrnIhOnZwklWBZno5VW2z0456T+jJM0MuS1+7ImxMOdjOuPt/mqSirF+fsM4GH/QDBkGfqQMcyIH9hpv5ZOq0Cg/Q3xcFyx10vHkb3M28K496R3JXcrznjeWX+r21vXx4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743948112; c=relaxed/simple;
	bh=HWQMVf432WjBTrh2hTZl6Ux9m4pnXLYvV3GaU57JdAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sla5P8aCbO3apO8852Avv4JeQGU4Nqd/0B3pPesNAtk0zkH1BXt/0kmMXRltDmjrZcF2f2Vc5eP7UADeTf4sYRC78r0vPuUB4Sw4vjnIe3/nbK9gG2IFXF9Pje4B4w0/mBYEgUsJ7HkdGJ0MAssolRk2Apt+ur5UCGaxlB56Ya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org; spf=pass smtp.mailfrom=archlinuxcn.org; dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b=EhkoSA5W; arc=none smtp.client-ip=104.245.9.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinuxcn.org
DKIM-Signature: a=rsa-sha256; bh=NoNx0hah2eI/83or9DwDO279ssc3irPpedpGkRkA2Ok=;
 c=relaxed/relaxed; d=archlinuxcn.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@archlinuxcn.org; s=default; t=1743948089; v=1; x=1744380089;
 b=EhkoSA5W1VSq0VRzknMRS/LefNNExbunC/QBOVIpsdyNqmXoFB7Ex8sGHMxiHBBcFyyDVPYG
 j+IpEoIx0h37L45wG+1OMAWECUAhiLazZweLT8E1iNF5c/VjSk02VoBqvupGE6EucNSw21RmBom
 JHwdmFtA6EI6dRs4jjemr6B4dbw/hhlOpjs2FEWhXpNCjskn3NKG8l3RqLDbnLuu6ILndCpVKMP
 +FY+aKFB6mz+9TpqUIAT06J+X85/uRAKhuxs/p5KYtvJ35V4b0oqAOwNpGvKMGO+0TKyeMHNu6V
 pwczjhWf2OeQuiPJ55i6bf0U0YoYx5kVVVSiBjM2DOXdQ==
Received: by wiki.archlinuxcn.org (envelope-sender
 <integral@archlinuxcn.org>) with ESMTPS id 32ceeaf9; Sun, 06 Apr 2025
 22:01:29 +0800
From: Integral <integral@archlinuxcn.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Integral <integral@archlinuxcn.org>
Subject: [PATCH] bcachefs: return early for negative values when parsing BCH_OPT_UINT
Date: Sun,  6 Apr 2025 21:59:30 +0800
Message-ID: <20250406135929.178583-2-integral@archlinuxcn.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when a negative integer is passed as an argument, the error
message incorrectly states "too big" due to the value being cast to an
unsigned integer:

    > bcachefs format --block_size=-1 bcachefs.img
    invalid option: block_size: too big (max 65536)

To resolve this issue, return early for negative values before calling
bch2_opt_validate().

Signed-off-by: Integral <integral@archlinuxcn.org>
---
 fs/bcachefs/opts.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
index e64777ecf44f..31f90c177c6c 100644
--- a/fs/bcachefs/opts.c
+++ b/fs/bcachefs/opts.c
@@ -360,9 +360,15 @@ int bch2_opt_parse(struct bch_fs *c,
 			return -EINVAL;
 		}
 
-		ret = opt->flags & OPT_HUMAN_READABLE
-			? bch2_strtou64_h(val, res)
-			: kstrtou64(val, 10, res);
+		if (*val != '-') {
+			ret = opt->flags & OPT_HUMAN_READABLE
+			    ? bch2_strtou64_h(val, res)
+			    : kstrtou64(val, 10, res);
+		} else {
+			prt_printf(err, "%s: must be a non-negative number", opt->attr.name);
+			return -EINVAL;
+		}
+
 		if (ret < 0) {
 			if (err)
 				prt_printf(err, "%s: must be a number",
-- 
2.49.0


