Return-Path: <linux-kernel+bounces-801976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CEBB44C44
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041D35875DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC7E24A06A;
	Fri,  5 Sep 2025 03:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="X8ihi48I"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF12EEBD;
	Fri,  5 Sep 2025 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757042874; cv=pass; b=CuuMtugnQNtv1qqZw/UTU8rGkUnMtEXAdJIHAP/xzU2n0ylSIzOHlB8WXshpup75yjP23DgMccCuiBDHbswZs0LpVKb6oQmidAlP9ZnTI536fArZ5BWJr1ryiVRNRZUqZRpRPReT+Xe6yr7AmvPDXT59kG0nvf46DqxibhwrGcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757042874; c=relaxed/simple;
	bh=vfcYQ/FN9o6FE/ZXdUwR8GaKdJ3N3R19zv6RknNZVBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ckeC8zUmrJ+XsnNFItrV5UnOj035Dnhx3ZqkbFwfIAhbrrAvfJXAAvbhwaBJqJsA4+6tUCvH2scpwKbYkMFa6FPqdBuEOTsKm+ggLp8oRyj7coz448rXO5RRJePXJaPXsfF0gRDnWkI0B4esHxtO2Cs8fhIhNKn4SkXUlSwJDnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=X8ihi48I; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5853Rhhi097613
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 5 Sep 2025 12:27:43 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id CCB5E109D5675;
	Fri,  5 Sep 2025 12:27:42 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J8YCdhpB346I; Fri,  5 Sep 2025 12:27:38 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id D7892109EFCDE; Fri,  5 Sep 2025 12:27:37 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757042857;
	cv=none; b=xhmau25KID8WkN1isQ6OAcje5eV+Nf3oK5pEOKpiHH6fKG/RM2RxtFiYyNQcjPueLRoZFdhqWkhxzfDbvVXKdonX5gkESVKo1QuOwhslmoyrqm+yRKQ3xKYLjNfsxkfAD4z8lGf33heyhMi2Y21x8IIm2pvUBIWAmiZ6STYchlk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757042857; c=relaxed/relaxed;
	bh=66+PbdQB6GijM0MPBjzUoqsDFZwav04yEvjAynzsHNM=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding; b=vjd+2ooFDZ5BmKWZT4cWgN4cmd57f9Xy06LoMpAMNi9IgI7K3VUUABmjVkEBZPiE372w5bLh8DcixSZraFUdjAjCO8r/ggC2RTZMynAkys9aAjer6sBPCAzkyel4zJbsrYizHTgjaKvgJ4Tdl8pPpH3FdKVIbFTTopUbtxKhgic=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org D7892109EFCDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757042857;
	bh=66+PbdQB6GijM0MPBjzUoqsDFZwav04yEvjAynzsHNM=;
	h=From:To:Cc:Subject:Date:From;
	b=X8ihi48IhdHypotbGm/cos/F004+HsdK6bszWjygNrVsFyTeWcNpOlusfXaBLpzAd
	 4h/P6Gld/tE39HW9xEWuZ5Y1l5Pw7YM13Y0mt1H9mWYzopKX88x/k1B3zcfDos7m4J
	 S9LC3pgasMwlFcJMq8VwXJqnFklVsHqDiJPZYzPg=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net, akiyks@gmail.com,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] docs: ja_JP: add guidance for the Fixes: tag in SubmittingPatches
Date: Fri,  5 Sep 2025 12:27:29 +0900
Message-ID: <20250905032729.2284883-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The Japanese translation of SubmittingPatches was missing the section
describing the use of the 'Fixes:' tag. This patch adds the missing
description, aligning the translation with commit 8401aa1f5997
("Documentation/SubmittingPatches: describe the Fixes: tag") in the
English version.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 .../translations/ja_JP/SubmittingPatches      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documenta=
tion/translations/ja_JP/SubmittingPatches
index 5334db471744..28ad83171252 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -132,6 +132,27 @@ http://savannah.nongnu.org/projects/quilt
        platform_set_drvdata(), but left the variable "dev" unused,
        delete it.
=20
+=E7=89=B9=E5=AE=9A=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AE=
=E3=83=90=E3=82=B0=E3=82=92=E4=BF=AE=E6=AD=A3=E3=81=99=E3=82=8B=E3=83=91=E3=
=83=83=E3=83=81=E3=81=AE=E5=A0=B4=E5=90=88=EF=BC=88=E4=BE=8B=EF=BC=9A``git =
bisect``=E3=81=A7=E5=95=8F=E9=A1=8C=E3=82=92=E7=99=BA=E8=A6=8B=E3=81=97=E3=
=81=9F=E5=A0=B4=E5=90=88=EF=BC=89=E3=80=81
+=E5=B0=91=E3=81=AA=E3=81=8F=E3=81=A8=E3=82=82 SHA-1 ID =E3=81=AE=E6=9C=80=
=E5=88=9D=E3=81=AE 12 =E6=96=87=E5=AD=97=E3=81=A8 1 =E8=A1=8C=E3=81=AE=E8=
=A6=81=E7=B4=84=E3=82=92=E8=A8=98=E8=BC=89=E3=81=97=E3=81=9F=E3=80=8CFixes:=
=E3=80=8D=E3=82=BF=E3=82=B0=E3=82=92=E4=BD=BF=E7=94=A8=E3=81=97=E3=81=A6=E3=
=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82
+=E3=82=BF=E3=82=B0=E3=82=92=E8=A4=87=E6=95=B0=E8=A1=8C=E3=81=AB=E5=88=86=
=E5=89=B2=E3=81=97=E3=81=AA=E3=81=84=E3=81=A7=E3=81=8F=E3=81=A0=E3=81=95=E3=
=81=84=E3=80=82=E8=A7=A3=E6=9E=90=E3=82=B9=E3=82=AF=E3=83=AA=E3=83=97=E3=83=
=88=E3=82=92=E7=B0=A1=E7=B4=A0=E5=8C=96=E3=81=99=E3=82=8B=E3=81=9F=E3=82=81=
=E3=80=81=E3=82=BF=E3=82=B0=E3=81=AF
+=E3=80=8C75 =E6=96=87=E5=AD=97=E3=81=A7=E6=8A=98=E3=82=8A=E8=BF=94=E3=81=
=99=E3=80=8D=E3=83=AB=E3=83=BC=E3=83=AB=E3=81=8B=E3=82=89=E9=99=A4=E5=A4=96=
=E3=81=95=E3=82=8C=E3=81=BE=E3=81=99=E3=80=82
+
+=E4=BE=8B:
+
+        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the=
 number of pages it actually freed")
+
+=E4=BB=A5=E4=B8=8B=E3=81=AE ``git config`` =E8=A8=AD=E5=AE=9A=E3=82=92=E4=
=BD=BF=E7=94=A8=E3=81=99=E3=82=8B=E3=81=A8=E3=80=81``git log`` =E3=82=84 ``=
git show`` =E3=82=B3=E3=83=9E=E3=83=B3=E3=83=89=E3=81=A7
+=E4=B8=8A=E8=A8=98=E5=BD=A2=E5=BC=8F=E3=82=92=E5=87=BA=E5=8A=9B=E3=81=99=
=E3=82=8B=E9=9A=9B=E3=81=AB=E3=83=97=E3=83=AA=E3=83=86=E3=82=A3=E3=83=95=E3=
=82=A9=E3=83=BC=E3=83=9E=E3=83=83=E3=83=88=E3=82=92=E8=BF=BD=E5=8A=A0=E3=81=
=A7=E3=81=8D=E3=81=BE=E3=81=99::
+
+        [core]
+                abbrev =3D 12
+        [pretty]
+                fixes =3D Fixes: %h (\"%s\")
+
+=E5=91=BC=E3=81=B3=E5=87=BA=E3=81=97=E4=BE=8B::
+
+        $ git log -1 --pretty=3Dfixes 54a4f0239f2e
+        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the=
 number of pages it actually freed")
=20
 3) =E3=83=91=E3=83=83=E3=83=81=E3=81=AE=E5=88=86=E5=89=B2
=20
--=20
2.47.3


