Return-Path: <linux-kernel+bounces-831148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C8FB9BB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A532A3815A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7062DECA1;
	Wed, 24 Sep 2025 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="TyT9uK8m"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA31C8603;
	Wed, 24 Sep 2025 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741886; cv=pass; b=iuDApX9H8Ik3CZPS83IB8w/NCHSMxGGII3XJtHW67tDJTPeZY0/MhYoM6yC9dkvyGUrCOsvPsu5eVtGhY4Twm/sdfOqkqLFSBwkzZJJ7iOvNNTUv48CledDs+o6++lYAXMqIU+RpWOA1XOUVrBDGhY/O8m+O9aiM5oXlcvMXtZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741886; c=relaxed/simple;
	bh=heESk4oHqAuXRn33U0ViCuV3zVQBKzbyLAkSWgCK09o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDFsiNjYoyBE9d0c8XIMYLkHp0QiT66TRWOzxxEUYzsE7WhoIuziJXqaE6VTyTW0kLTi+chCfXzjywcFxWS6oHQV4xPSajhYYvgLcp7MDUYUCr02ofnaFOChrc/yc8UNfVkxhT5HFPdfrUIYKRjl3E5b3ELOF/zX21bKYCIOVMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=TyT9uK8m; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 0A5F3101C8635;
	Thu, 25 Sep 2025 04:24:34 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQ4Lfu_r75o5; Thu, 25 Sep 2025 04:24:28 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id C0768101C8441; Thu, 25 Sep 2025 04:24:28 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758741868;
	cv=none; b=ZupupkXhJiUL7K5Zb04EQmzag7d4eDS6EV//uUTxUAN0dLqcnjCPtDQefPDZos2TsDhowsuUBA2Inu3ThD3gIJ8hrGRRZMmBnupnQouH/NTcJGFWALe3ZITpvqNA0bqCxqH7uLphDoL6A+HA7jE0AA4Ixlem0wNYyqVLSvikEaY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758741868; c=relaxed/relaxed;
	bh=b3PFU9BpTy364X6+cV+ReTpHMpe0gUd/ubx4lz7SF3g=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=SW0qExqqWowD49+fzCkMjaKKWoVRuzzNDPhpaD2bAdWKtQMvlVA4jEfBzSm0Xooaf2XViLumYviwVPN+nPK9gdITcNSR4YLIU/dRX0fiYIRWqxMPBYfmBdu6EnxAr1ICZx43f6zGG+QBuqHsadxveTmrgo3og/Vsvt0rKYyv3Ok=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org C0768101C8441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758741868;
	bh=b3PFU9BpTy364X6+cV+ReTpHMpe0gUd/ubx4lz7SF3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TyT9uK8mPbzPY16aPTaZe9AZhiVaqWmpZVSIHLQxKmz2v91TO5Ih0uqgqpZc/Wkoh
	 S87Sd+yCJ+qA2LDvMkqJGQO14madXYcgBMRLz5mYgHKBybR6/Q6aSv/8JY29QXZDOv
	 dPjjwYcPO4d+FA6tQj9muf/hy6Ri4hYgdqlUtrgI=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	akiyks@gmail.com,
	linux-kernel@vger.kernel.org,
	weibu@redadmin.org
Subject: [PATCH v5] docs: ja_JP: SubmittingPatches: describe the 'Fixes:' tag
Date: Thu, 25 Sep 2025 04:24:26 +0900
Message-ID: <20250924192426.2743495-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909022502.119560-1-weibu@redadmin.org>
References: <20250909022502.119560-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sync the ja_JP translation with the following upstream commits:

commit 8401aa1f5997 ("Documentation/SubmittingPatches: describe the Fixes: =
tag")
commit 19c3fe285cba ("docs: Explicitly state that the 'Fixes:' tag shouldn'=
t split lines")
commit 5b5bbb8cc51b ("docs: process: Add an example for creating a fixes ta=
g")
commit 6356f18f09dc ("Align git commit ID abbreviation guidelines and check=
s")

The mix of plain text and reST markup for ``git bisect`` is intentional to
align with the eventual reST conversion.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
v5:
 - whole rewrite
---
 .../translations/ja_JP/SubmittingPatches      | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documenta=
tion/translations/ja_JP/SubmittingPatches
index 5334db471744..b950347b5993 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -132,6 +132,25 @@ http://savannah.nongnu.org/projects/quilt
        platform_set_drvdata(), but left the variable "dev" unused,
        delete it.
=20
+=E7=89=B9=E5=AE=9A=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=A7=
=E5=B0=8E=E5=85=A5=E3=81=95=E3=82=8C=E3=81=9F=E4=B8=8D=E5=85=B7=E5=90=88=E3=
=82=92=E4=BF=AE=E6=AD=A3=E3=81=99=E3=82=8B=E5=A0=B4=E5=90=88=EF=BC=88=E4=BE=
=8B=E3=81=88=E3=81=B0 ``git bisect`` =E3=81=A7=E5=8E=9F=E5=9B=A0=E3=81=A8=
=E3=81=AA=E3=81=A3=E3=81=9F
+=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=E7=89=B9=E5=AE=9A=E3=81=97=
=E3=81=9F=E3=81=A8=E3=81=8D=E3=81=AA=E3=81=A9=EF=BC=89=E3=81=AF=E3=80=81=E3=
=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AE SHA-1 =E3=81=AE=E5=85=88=E9=A0=
=AD12=E6=96=87=E5=AD=97=E3=81=A81=E8=A1=8C=E3=81=AE=E8=A6=81=E7=B4=84=E3=82=
=92=E6=B7=BB=E3=81=88=E3=81=9F
+=E3=80=8CFixes:=E3=80=8D=E3=82=BF=E3=82=B0=E3=82=92=E4=BB=98=E3=81=91=E3=
=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82=E3=81=93=E3=81=AE=E8=A1=
=8C=E3=81=AF75=E6=96=87=E5=AD=97=E3=82=92=E8=B6=85=E3=81=88=E3=81=A6=E3=82=
=82=E6=A7=8B=E3=81=84=E3=81=BE=E3=81=9B=E3=82=93=E3=81=8C=E3=80=81=E9=80=94=
=E4=B8=AD=E3=81=A7
+=E6=94=B9=E8=A1=8C=E3=81=9B=E3=81=9A=E3=80=81=E5=BF=85=E3=81=9A1=E8=A1=8C=
=E3=81=A7=E8=A8=98=E8=BF=B0=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=
=81=84=E3=80=82
+=E4=BE=8B:
+        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the=
 number of pages it actually freed")
+
+=E4=BB=A5=E4=B8=8B=E3=81=AE git =E3=81=AE=E8=A8=AD=E5=AE=9A=E3=82=92=E4=BD=
=BF=E3=81=86=E3=81=A8=E3=80=81git log =E3=82=84 git show =E3=81=A7=E4=B8=8A=
=E8=A8=98=E5=BD=A2=E5=BC=8F=E3=82=92=E5=87=BA=E5=8A=9B=E3=81=99=E3=82=8B=E3=
=81=9F=E3=82=81=E3=81=AE
+=E5=B0=82=E7=94=A8=E3=81=AE=E5=87=BA=E5=8A=9B=E5=BD=A2=E5=BC=8F=E3=82=92=
=E8=BF=BD=E5=8A=A0=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=99::
+
+        [core]
+                abbrev =3D 12
+        [pretty]
+                fixes =3D Fixes: %h (\"%s\")
+
+=E4=BD=BF=E7=94=A8=E4=BE=8B::
+
+        $ git log -1 --pretty=3Dfixes 54a4f0239f2e
+        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the=
 number of pages it actually freed")
=20
 3) =E3=83=91=E3=83=83=E3=83=81=E3=81=AE=E5=88=86=E5=89=B2
=20
@@ -409,7 +428,7 @@ Acked-by: =E3=81=8C=E5=BF=85=E3=81=9A=E3=81=97=E3=82=82=
=E3=83=91=E3=83=83=E3=83=81=E5=85=A8=E4=BD=93=E3=81=AE=E6=89=BF=E8=AA=8D=E3=
=82=92=E7=A4=BA=E3=81=97=E3=81=A6=E3=81=84=E3=82=8B=E3=82=8F=E3=81=91=E3=81=
=A7=E3=81=AF
 =E3=81=93=E3=81=AE=E3=82=BF=E3=82=B0=E3=81=AF=E3=83=91=E3=83=83=E3=83=81=
=E3=81=AB=E9=96=A2=E5=BF=83=E3=81=8C=E3=81=82=E3=82=8B=E3=81=A8=E6=80=9D=E3=
=82=8F=E3=82=8C=E3=82=8B=E4=BA=BA=E9=81=94=E3=81=8C=E3=81=9D=E3=81=AE=E3=83=
=91=E3=83=83=E3=83=81=E3=81=AE=E8=AD=B0=E8=AB=96=E3=81=AB=E5=90=AB=E3=81=BE=
=E3=82=8C=E3=81=A6=E3=81=84=E3=81=9F=E3=81=93=E3=81=A8
 =E3=82=92=E6=98=8E=E6=96=87=E5=8C=96=E3=81=97=E3=81=BE=E3=81=99=E3=80=82
=20
-14) Reported-by:, Tested-by:, Reviewed-by: =E3=81=8A=E3=82=88=E3=81=B3 Sug=
gested-by: =E3=81=AE=E5=88=A9=E7=94=A8
+14) Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: =E3=81=8A=E3=82=
=88=E3=81=B3 Fixes: =E3=81=AE=E5=88=A9=E7=94=A8
=20
 =E4=BB=96=E3=81=AE=E8=AA=B0=E3=81=8B=E3=81=AB=E3=82=88=E3=81=A3=E3=81=A6=
=E5=A0=B1=E5=91=8A=E3=81=95=E3=82=8C=E3=81=9F=E5=95=8F=E9=A1=8C=E3=82=92=E4=
=BF=AE=E6=AD=A3=E3=81=99=E3=82=8B=E3=83=91=E3=83=83=E3=83=81=E3=81=A7=E3=81=
=82=E3=82=8C=E3=81=B0=E3=80=81=E5=95=8F=E9=A1=8C=E5=A0=B1=E5=91=8A=E8=80=85=
=E3=81=A8=E3=81=84=E3=81=86=E5=AF=84=E4=B8=8E=E3=82=92
 =E3=82=AF=E3=83=AC=E3=82=B8=E3=83=83=E3=83=88=E3=81=99=E3=82=8B=E3=81=9F=
=E3=82=81=E3=81=AB=E3=80=81Reported-by: =E3=82=BF=E3=82=B0=E3=82=92=E8=BF=
=BD=E5=8A=A0=E3=81=99=E3=82=8B=E3=81=93=E3=81=A8=E3=82=92=E6=A4=9C=E8=A8=8E=
=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82
@@ -465,6 +484,13 @@ Suggested-by: =E3=82=BF=E3=82=B0=E3=81=AF=E3=80=81=E3=
=83=91=E3=83=83=E3=83=81=E3=81=AE=E3=82=A2=E3=82=A4=E3=83=87=E3=82=A2=E3=81=
=8C=E3=81=9D=E3=81=AE=E4=BA=BA=E3=81=8B=E3=82=89=E3=81=AE=E6=8F=90=E6=A1=88=
=E3=81=AB
 =E3=82=AF=E3=83=AC=E3=82=B8=E3=83=83=E3=83=88=E3=81=97=E3=81=A6=E3=81=84=
=E3=81=91=E3=81=B0=E3=80=81=E6=9C=9B=E3=82=80=E3=82=89=E3=81=8F=E3=81=AF=E3=
=81=9D=E3=81=AE=E4=BA=BA=E3=81=9F=E3=81=A1=E3=81=8C=E5=B0=86=E6=9D=A5=E5=88=
=A5=E3=81=AE=E6=A9=9F=E4=BC=9A=E3=81=AB=E5=86=8D=E5=BA=A6=E5=8A=9B=E3=82=92=
=E8=B2=B8=E3=81=99=E6=B0=97=E3=81=AB
 =E3=81=AA=E3=81=A3=E3=81=A6=E3=81=8F=E3=82=8C=E3=82=8B=E3=81=8B=E3=82=82=
=E3=81=97=E3=82=8C=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82
=20
+Fixes: =E3=82=BF=E3=82=B0=E3=81=AF=E3=80=81=E3=81=9D=E3=81=AE=E3=83=91=E3=
=83=83=E3=83=81=E3=81=8C=E4=BB=A5=E5=89=8D=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=
=83=E3=83=88=E3=81=AB=E3=81=82=E3=81=A3=E3=81=9F=E5=95=8F=E9=A1=8C=E3=82=92=
=E4=BF=AE=E6=AD=A3=E3=81=99=E3=82=8B=E3=81=93=E3=81=A8=E3=82=92=E7=A4=BA=E3=
=81=97=E3=81=BE=E3=81=99=E3=80=82
+=E3=81=93=E3=82=8C=E3=81=AF=E3=80=81=E3=83=90=E3=82=B0=E3=81=8C=E3=81=A9=
=E3=81=93=E3=81=A7=E7=99=BA=E7=94=9F=E3=81=97=E3=81=9F=E3=81=8B=E3=82=92=E7=
=89=B9=E5=AE=9A=E3=81=97=E3=82=84=E3=81=99=E3=81=8F=E3=81=97=E3=80=81=E3=83=
=90=E3=82=B0=E4=BF=AE=E6=AD=A3=E3=81=AE=E3=83=AC=E3=83=93=E3=83=A5=E3=83=BC=
=E3=81=AB=E5=BD=B9=E7=AB=8B=E3=81=A1=E3=81=BE=E3=81=99=E3=80=82
+=E3=81=BE=E3=81=9F=E3=80=81=E3=81=93=E3=81=AE=E3=82=BF=E3=82=B0=E3=81=AFst=
able=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=81=E3=83=BC=E3=83=A0=E3=81=
=8C=E3=80=81=E3=81=82=E3=81=AA=E3=81=9F=E3=81=AE=E4=BF=AE=E6=AD=A3=E3=82=92=
=E3=81=A9=E3=81=AEstable=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB
+=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3=E3=81=AB=E9=81=A9=E7=94=A8=
=E3=81=99=E3=81=B9=E3=81=8D=E3=81=8B=E5=88=A4=E6=96=AD=E3=81=99=E3=82=8B=E6=
=89=8B=E5=8A=A9=E3=81=91=E3=81=AB=E3=82=82=E3=81=AA=E3=82=8A=E3=81=BE=E3=81=
=99=E3=80=82=E3=83=91=E3=83=83=E3=83=81=E3=81=AB=E3=82=88=E3=81=A3=E3=81=A6=
=E4=BF=AE=E6=AD=A3=E3=81=95=E3=82=8C=E3=81=9F
+=E3=83=90=E3=82=B0=E3=82=92=E7=A4=BA=E3=81=99=E3=81=AB=E3=81=AF=E3=80=81=
=E3=81=93=E3=81=AE=E6=96=B9=E6=B3=95=E3=81=8C=E6=8E=A8=E5=A5=A8=E3=81=95=E3=
=82=8C=E3=81=BE=E3=81=99=E3=80=82=E5=89=8D=E8=BF=B0=E3=81=AE=E3=80=81=E3=80=
=8C2) =E3=83=91=E3=83=83=E3=83=81=E3=81=AB=E5=AF=BE=E3=81=99=E3=82=8B=E8=AA=
=AC=E6=98=8E=E3=80=8D=E3=81=AE
+=E3=82=BB=E3=82=AF=E3=82=B7=E3=83=A7=E3=83=B3=E3=82=92=E5=8F=82=E7=85=A7=
=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82
+
 15) =E6=A8=99=E6=BA=96=E7=9A=84=E3=81=AA=E3=83=91=E3=83=83=E3=83=81=E3=81=
=AE=E3=83=95=E3=82=A9=E3=83=BC=E3=83=9E=E3=83=83=E3=83=88
=20
 =E6=A8=99=E6=BA=96=E7=9A=84=E3=81=AA=E3=83=91=E3=83=83=E3=83=81=E3=81=AE=
=E3=82=B5=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=81=AF=E4=BB=A5=E4=
=B8=8B=E3=81=AE=E3=81=A8=E3=81=8A=E3=82=8A=E3=81=A7=E3=81=99=E3=80=82
--=20
2.47.3


