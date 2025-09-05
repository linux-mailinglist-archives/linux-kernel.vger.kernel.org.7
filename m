Return-Path: <linux-kernel+bounces-802726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A61B45608
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EE01BC1128
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C370346A1F;
	Fri,  5 Sep 2025 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="N/+c8GSi"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025DF343D9C;
	Fri,  5 Sep 2025 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070854; cv=pass; b=k0HljK6QoukiaNrS0/fwtbvfLqdEV/6Igf1YpsKqDBh0MD/N8wIiGdUegrCrHDVM7OX8ilwPu9D7ua3jUwK3kSak9+Mmnj+xoR/6n8QWHMiUC7OesmRLXbbx+ocNbteu5XRjj2cq46cSArS8z3esDmFpEWqAL2bvwAGhwJKFvwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070854; c=relaxed/simple;
	bh=DvfqA9xZcWTReEc/5DRq88nW2Mz6rtbni5rCLasMu98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxjFst8Mutt4GV2nYxQZ00+dJ6SWMb0vCtd6vphj1QxC4JxgLKUJskFviAjpNplmjE6CHur1E8ZvvhVuqWYhP0dsg7HlfG/TJ/hx8DNMYQpi9zpgLtZUt2sKX087E3gv0tth280aP7dsi5jsg46eJxwot6KAs+yYo7nIyGrOaTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=N/+c8GSi; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 9BD08109D5675;
	Fri,  5 Sep 2025 20:14:08 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FeTibDPu7pKP; Fri,  5 Sep 2025 20:14:03 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 97ABB109EFCDE; Fri,  5 Sep 2025 20:14:03 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757070843;
	cv=none; b=AyQWa8lJeKGVsRRYYMbUriGof1LYiczTZV6aqiR6XvMIe8IjeNyg0LiFIVjQoBbeTz+Uo2mkqQh+oBGT6N7CicyMwkFEt/Ja9wOBYsqItOIJ/gXdT8E2ObV+mACx2qO0oyIP0gqEhY7Uk80+H9da7IcGILcxZ5QwWngLxkLBR1I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757070843; c=relaxed/relaxed;
	bh=qoNLBCwimBHSI5XzBSqteKL9QfIJJmy3G9OZaN2je1s=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=bEL29SKLQYaoZDuEKwC8q3HQIJ4MZMIp+r0yu/mi9LDwSUBoacJ1TIXxF/40jTYB30dWKR7Gj0fGI8f17ieJXBMKLL/8WBAicu778AZxM0C+432XXNU39dDtQHn9L9dv/fD/PKwflv8ZnHvH8DqyFoubybP1k7oXDRwV2YwBYLg=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 97ABB109EFCDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757070843;
	bh=qoNLBCwimBHSI5XzBSqteKL9QfIJJmy3G9OZaN2je1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/+c8GSids57XX9NxWYHU9ZwBHDE1FADSFRgI8osrYbz2eqH3WpVhpTrjz9iLTnpG
	 kZBC20eQKNfuyYXR2Ral/K5mAMUgpNB79ZUA8AIUtue/qlly3rF8cV4PKrfavD8Eu1
	 Zs5RrjxLgz0hSbBaO1zI31y+Z5TxpzBMqi+FJl+g=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	akiyks@gmail.com
Subject: [PATCH v2] docs: ja_JP: SubmittingPatches: document the 'Fixes:' tag (+example)
Date: Fri,  5 Sep 2025 20:14:03 +0900
Message-ID: <20250905111403.2338934-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905032729.2284883-1-weibu@redadmin.org>
References: <20250905032729.2284883-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sync the ja_JP translation with parts of:
  - 8401aa1f5997 ("Documentation/SubmittingPatches: describe the Fixes: tag=
")
  - 5b5bbb8cc51be ("docs: process: Add an example for creating a fixes tag")

Link: https://lore.kernel.org/all/20250905032729.2284883-1-weibu@redadmin.o=
rg/
Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>

---
v2:
  - Add explanatory paragraphs from 8401aa1f5997 (purpose + stable note)
  - Keep example and pretty-format from 5b5bbb8cc51be
 Documentation/translations/ja_JP/SubmittingPatches | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documenta=
tion/translations/ja_JP/SubmittingPatches
index 28ad83171252..a05829427591 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -154,6 +154,18 @@ http://savannah.nongnu.org/projects/quilt
         $ git log -1 --pretty=3Dfixes 54a4f0239f2e
         Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the=
 number of pages it actually freed")
=20
+
+=E3=80=8CFixes:=E3=80=8D=E3=82=BF=E3=82=B0=E3=81=AF=E3=80=81=E3=81=9D=E3=
=81=AE=E3=83=91=E3=83=83=E3=83=81=E3=81=8C=E9=81=8E=E5=8E=BB=E3=81=AE=E3=82=
=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AB=E8=B5=B7=E5=9B=A0=E3=81=99=E3=82=8B=
=E5=95=8F=E9=A1=8C=E3=82=92=E4=BF=AE=E6=AD=A3=E3=81=97=E3=81=A6=E3=81=84=E3=
=82=8B=E3=81=93=E3=81=A8=E3=82=92=E7=A4=BA=E3=81=97=E3=81=BE=E3=81=99=E3=80=
=82
+=E3=81=93=E3=81=AE=E3=82=BF=E3=82=B0=E3=81=AF=E3=83=90=E3=82=B0=E3=81=AE=
=E8=B5=B7=E6=BA=90=E3=82=92=E7=89=B9=E5=AE=9A=E3=81=97=E3=82=84=E3=81=99=E3=
=81=8F=E3=81=97=E3=80=81=E3=83=90=E3=82=B0=E4=BF=AE=E6=AD=A3=E3=81=AE=E3=83=
=AC=E3=83=93=E3=83=A5=E3=83=BC=E3=81=AB=E5=BD=B9=E7=AB=8B=E3=81=A1=E3=81=BE=
=E3=81=99=E3=80=82
+=E3=81=BE=E3=81=9F=E3=80=81=E3=81=93=E3=81=AE=E3=82=BF=E3=82=B0=E3=81=AF=
=E3=81=A9=E3=81=AE=E5=AE=89=E5=AE=9A=E7=89=88=EF=BC=88stable=EF=BC=89=E3=82=
=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=81=8C=E3=81=82=E3=81=AA=E3=81=9F=E3=81=AE=
=E4=BF=AE=E6=AD=A3=E3=82=92=E5=8F=96=E3=82=8A=E8=BE=BC=E3=82=80=E3=81=B9=E3=
=81=8D=E3=81=8B=E3=82=92=E5=88=A4=E6=96=AD=E3=81=99=E3=82=8B=E9=9A=9B=E3=81=
=AB=E3=80=81
+stable =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=81=E3=83=BC=E3=83=A0=E3=
=82=92=E6=94=AF=E6=8F=B4=E3=81=97=E3=81=BE=E3=81=99=E3=80=82=E3=83=91=E3=83=
=83=E3=83=81=E3=81=AB=E3=82=88=E3=81=A3=E3=81=A6=E4=BF=AE=E6=AD=A3=E3=81=95=
=E3=82=8C=E3=82=8B=E3=83=90=E3=82=B0=E3=82=92=E7=A4=BA=E3=81=99=E3=81=9F=E3=
=82=81=E3=81=AE=E6=8E=A8=E5=A5=A8=E3=81=95=E3=82=8C=E3=82=8B=E6=96=B9=E6=B3=
=95=E3=81=A7=E3=81=99=E3=80=82
+=E8=A9=B3=E7=B4=B0=E3=81=AF :ref:`describe_changes` =E3=82=92=E5=8F=82=E7=
=85=A7=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82
+
+=E6=B3=A8=E6=84=8F: =E3=80=8CFixes:=E3=80=8D=E3=82=BF=E3=82=B0=E3=82=92=E4=
=BB=98=E3=81=91=E3=81=A6=E3=82=82=E3=80=81stable =E3=82=AB=E3=83=BC=E3=83=
=8D=E3=83=AB=E3=81=AE=E9=81=8B=E7=94=A8=E3=83=AB=E3=83=BC=E3=83=AB=E3=81=AE=
=E6=89=8B=E7=B6=9A=E3=81=8D=E3=82=92=E8=BF=82=E5=9B=9E=E3=81=99=E3=82=8B=E3=
=82=82=E3=81=AE=E3=81=A7=E3=81=AF=E3=81=AA=E3=81=8F=E3=80=81
+stable =E3=81=AE=E5=80=99=E8=A3=9C=E3=81=A8=E3=81=AA=E3=82=8B=E3=81=99=E3=
=81=B9=E3=81=A6=E3=81=AE=E3=83=91=E3=83=83=E3=83=81=E3=81=AB=E3=80=8CCc: st=
able@vger.kernel.org=E3=80=8D=E3=82=92=E4=BB=98=E3=81=91=E3=82=8B=E3=81=A8=
=E3=81=84=E3=81=86=E8=A6=81=E4=BB=B6=E3=81=8C
+=E7=BD=AE=E3=81=8D=E6=8F=9B=E3=81=88=E3=82=89=E3=82=8C=E3=82=8B=E3=82=8F=
=E3=81=91=E3=81=A7=E3=81=AF=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93=E3=
=80=82=E8=A9=B3=E3=81=97=E3=81=8F=E3=81=AF Documentation/process/stable-ker=
nel-rules.rst =E3=82=92=E5=8F=82=E7=85=A7=E3=81=97=E3=81=A6=E3=81=8F=E3=81=
=A0=E3=81=95=E3=81=84=E3=80=82
+
+
 3) =E3=83=91=E3=83=83=E3=83=81=E3=81=AE=E5=88=86=E5=89=B2
=20
 =E6=84=8F=E5=91=B3=E3=81=AE=E3=81=82=E3=82=8B=E3=81=B2=E3=81=A8=E3=81=BE=
=E3=81=A8=E3=81=BE=E3=82=8A=E3=81=94=E3=81=A8=E3=81=AB=E5=A4=89=E6=9B=B4=E3=
=82=92=E5=80=8B=E3=80=85=E3=81=AE=E3=83=91=E3=83=83=E3=83=81=E3=83=95=E3=82=
=A1=E3=82=A4=E3=83=AB=E3=81=AB=E5=88=86=E3=81=91=E3=81=A6=E3=81=8F=E3=81=A0=
=E3=81=95=E3=81=84=E3=80=82
--=20
2.47.3


