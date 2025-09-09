Return-Path: <linux-kernel+bounces-807040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E200AB49F2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC284E6F4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624E246793;
	Tue,  9 Sep 2025 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="xXIIdccJ"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39102BB1D;
	Tue,  9 Sep 2025 02:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384720; cv=pass; b=P8ZtDY/HSYGbMJfE0wP09nxiaarwK24Mz0TIqQuwk6YMc90bXR0W0nSGKJJkNy49DWn2wZwfc7aHtVGLkkWA1TQx+kp4jR6OwLS9jkGyqpPIfJInE7wKxo07agboC8ueHI2TES6o72e0Nbl3aBVdsH+81o6DF3fjOWmoZttqHdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384720; c=relaxed/simple;
	bh=qT7W3hmFGCpLvlm1wEd0SRmar7pcfqzndYC2iGwfPiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h9mGMKBQBvARjw1JnPK30Y5cz/52d7xRQ83qaQOfoFhbqwkKu4NJp6mFqwz+51N9Kz++XEOpXD5qiLr3twBwODNQ9YGyvojy7naMmUCJpPKhMYj4EkB5PXxPfDZfl+9fvxfoYlGFu8tNnXJKod9F2xEMmvY2AsJPot2Y25cuTCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=xXIIdccJ; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5892PA16003452
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 9 Sep 2025 11:25:10 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 2D65D10A2494E;
	Tue,  9 Sep 2025 11:25:10 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id udnoESLKyQ0o; Tue,  9 Sep 2025 11:25:05 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id A7F3910A2494C; Tue,  9 Sep 2025 11:25:05 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757384705;
	cv=none; b=ItNxK1TlDxCfQuEgHveSjk/Wsd3gmX3Ucq+adD7UpL4gS6yeme1muR187Bhux6m41u6SfpTZsyf+50IH6I3CV/MnlzHm4d6d30cVua2ND/NhnKUVRcfCN7ifWhUuv466gt63uGvVRauIyB5r72peKJIhwPcbppd20ZjoUVtZPRo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757384705; c=relaxed/relaxed;
	bh=ursEj2B5kaOD3zU1p7LlEiDgVE5d6TPHTny9fEDB1Ck=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding; b=PXtuwFaQRnIkWrrSEYBOlGFHOrMzY50vDDAcgA1lHdfp1+LSrhkE0nvknNtYaJKEOX2n97r8XoS2foDojymnrzV5OANmOnHywQyR9VzriRCw8cZHSsRZjwH1upHRLIYYmMej7r8pscuZSUJlZeB8p9aN/T/WwFS9Jno4y0F36f0=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org A7F3910A2494C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757384705;
	bh=ursEj2B5kaOD3zU1p7LlEiDgVE5d6TPHTny9fEDB1Ck=;
	h=From:To:Cc:Subject:Date:From;
	b=xXIIdccJSBMyqqP0WmcQs/SdDRdGYgGaZ1nAw0x2q46ky7tE299l+NgpLE5i763t/
	 hYBSBr/TAGTC+V9LrN7dJ2FhVwnSTvl1moxYShfux0reqDJPcHx3t0y+ZcDOUsYsfD
	 o+2AJuE87gULaCOJvbr/SePPobdrga+oHeoqlAso=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net, akiyks@gmail.com, linux-kernel@vger.kernel.org,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH v4] docs: ja_JP: SubmittingPatches: describe the 'Fixes:' tag (12-char SHA-1 + pretty example)
Date: Tue,  9 Sep 2025 11:25:02 +0900
Message-ID: <20250909022502.119560-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Add a Japanese section describing the Fixes: tag, use a consistent
12-character SHA-1 in the example, and include the pretty-format
snippet to generate a Fixes: line with git log/show.
No functional changes.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>

---
v4:
  - Fix unnatural Japanese wording in the new Fixes: section for clarity.
  - No content change, only Japanese expression improved.
  - v4 fully replaces v3 (not incremental).

Link: https://lore.kernel.org/all/20250905032729.2284883-1-weibu@redadmin.o=
rg/
---
---
 Documentation/translations/ja_JP/SubmittingPatches | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documenta=
tion/translations/ja_JP/SubmittingPatches
index 1d1e9622eafe..65dc5f87351f 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -134,8 +134,8 @@ http://savannah.nongnu.org/projects/quilt
=20
 =E7=89=B9=E5=AE=9A=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=A7=
=E5=B0=8E=E5=85=A5=E3=81=95=E3=82=8C=E3=81=9F=E4=B8=8D=E5=85=B7=E5=90=88=E3=
=82=92=E4=BF=AE=E6=AD=A3=E3=81=99=E3=82=8B=E3=83=91=E3=83=83=E3=83=81=E3=81=
=A7=E3=81=82=E3=82=8B=E5=A0=B4=E5=90=88=EF=BC=88=E4=BE=8B=E3=81=88=E3=81=B0=
 ``git bisect`` =E3=81=A7
 =E5=95=8F=E9=A1=8C=E3=81=AE=E5=B0=8E=E5=85=A5=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E3=82=92=E7=89=B9=E5=AE=9A=E3=81=97=E3=81=9F=E5=A0=B4=E5=90=88=E3=
=81=AA=E3=81=A9=EF=BC=89=E3=80=81=E3=81=9D=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=
=83=E3=83=88=E3=82=92=E6=8C=87=E3=81=97=E7=A4=BA=E3=81=99=E3=81=9F=E3=82=81=
=E3=81=AB=E3=80=8CFixes:=E3=80=8D=E3=82=BF=E3=82=B0=E3=82=92
-=E4=BD=BF=E7=94=A8=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=
=E3=80=82=E4=B8=8B=E6=B5=81=E3=81=AE -stable =E7=B3=BB=E5=88=97=E3=81=A7=E3=
=81=AE=E8=87=AA=E5=8B=95=E3=83=94=E3=83=83=E3=82=AF=E3=82=A2=E3=83=83=E3=83=
=97=E3=81=AB=E3=82=82=E5=88=A9=E7=94=A8=E3=81=95=E3=82=8C=E3=82=8B=E3=81=9F=
=E3=82=81=E3=80=81**=E6=AD=A3=E7=A2=BA=E3=81=AA**
-=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88 ID =E3=81=A8 **1 =E8=A1=8C=E3=81=AE=
=E8=A6=81=E7=B4=84**=E3=82=92=E8=A8=98=E8=BC=89=E3=81=99=E3=82=8B=E3=81=93=
=E3=81=A8=E3=81=8C=E9=87=8D=E8=A6=81=E3=81=A7=E3=81=99=E3=80=82
+=E4=BD=BF=E7=94=A8=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=
=E3=80=82=E4=B8=8B=E6=B5=81=E3=81=AE -stable =E7=B3=BB=E5=88=97=E3=81=A7=E3=
=81=AE=E8=87=AA=E5=8B=95=E3=83=94=E3=83=83=E3=82=AF=E3=82=A2=E3=83=83=E3=83=
=97=E3=81=AB=E3=82=82=E5=88=A9=E7=94=A8=E3=81=95=E3=82=8C=E3=82=8B=E3=81=9F=
=E3=82=81=E6=AD=A3=E7=A2=BA=E3=81=AA
+=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88ID=E3=81=A81=E8=A1=8C=E3=81=AE=E8=A6=
=81=E7=B4=84=E3=82=92=E8=A8=98=E8=BC=89=E3=81=99=E3=82=8B=E3=81=93=E3=81=A8=
=E3=81=8C=E9=87=8D=E8=A6=81=E3=81=A7=E3=81=99=E3=80=82
=20
 =E6=9B=B8=E5=BC=8F=EF=BC=88SHA-1 =E3=81=AF=E7=9F=AD=E7=B8=AE 12 =E6=96=87=
=E5=AD=97=E3=81=AB=E7=B5=B1=E4=B8=80=EF=BC=89::
=20
--=20
2.47.3


