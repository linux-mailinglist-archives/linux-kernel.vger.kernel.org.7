Return-Path: <linux-kernel+bounces-807017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4827B49EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB074E6BB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129D92417F8;
	Tue,  9 Sep 2025 02:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="tz1JGzSR"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E422222B7;
	Tue,  9 Sep 2025 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383524; cv=pass; b=JDlTvgIdgTehWIQ6doPSohAgFjTNum+nz8UAfZI7muHJPGNXhNcTj1Ac62APr9aXA4Q6609ytBu05lTa9pWZDGbL0IYJbGPNY/PKh8DpjuAjmLeit90vG2MtjAmDRLrovBbXLYpb124aQ6Aj7gb+H+AZlvqiK801NaqI9gvnPJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383524; c=relaxed/simple;
	bh=0pMAVbvzO96mxa5XnXh3dn/JZYvHTBjAOFUdg8ZlKSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JubzeAPIvjw1LwI1Cj2YO0NWT+JS5F09VX+KI0721YkkCii1TkyAehXVn8/RDudShuMzXVgrpgA84Dst/DIp/ld/bH2JIsvZi3EWH8GaIpP1dx1McdUQ74oGvCYJIYWyQaafFJRo9wfqnBbUD4aajRq38Hglx2uHGiNqK08/xts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=tz1JGzSR; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58925DSc082006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 9 Sep 2025 11:05:13 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 2BA2410A2494E;
	Tue,  9 Sep 2025 11:05:13 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gGEnFcgF_Rfm; Tue,  9 Sep 2025 11:05:07 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id C45CB10A2494C; Tue,  9 Sep 2025 11:05:07 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757383507;
	cv=none; b=DkmL6BkWeOCGIjfDjQlljdEAKlO6rw22UDYX8vuYh3FzKAImKS+l6fhxuldbxT5inBqIyGJhYlFz+eTWPsiA9I9yVzNZwfF5e6KvHRpkMCFdAH+O4Kq8e9/HsEfDi4h4kGgTTwUwJehUl2+XeLJD8JtdsS86mIOE9zDQrZ3vO7U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757383507; c=relaxed/relaxed;
	bh=9uGpj2GAFhdWhgHoyB+TZTmyoI1bxNGUixFtUznDLUM=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding; b=NVpTm6wffibHgT5vYfxRasVu0Ol9K9wo1Yur6WJxEpin0/lTRTAJJxBQR9yxb7/SaHqbPjA3ogSlAUvhvv8RFjxPeZxyOUWLixaeXrOT5Mf/t+KnInoX8mGa2VwkpNEHwM4Fth5xU1NyKoqdoRe9SmBghAQIL2PYRLCrWd7K2Z0=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org C45CB10A2494C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757383507;
	bh=9uGpj2GAFhdWhgHoyB+TZTmyoI1bxNGUixFtUznDLUM=;
	h=From:To:Cc:Subject:Date:From;
	b=tz1JGzSRwcM4Df8u4oGluaWgbmbwQo+wAezlqcsW23v4vLmyK0rq4v5fc9z/VuoQb
	 wkikKR+b4xSH0b5by++Ie2UZVoE0CrHgiLTy3TCs2SnbXVhgxkCd5PZiKjYeYbOm10
	 X8tTzCrL7afoHxJI/Fd9L4yqyxj80x9EYAsR5F9c=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net, akiyks@gmail.com, linux-kernel@vger.kernel.org,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH v3] docs: ja_JP: SubmittingPatches: describe the 'Fixes:' tag (12-char SHA-1 + pretty example)
Date: Tue,  9 Sep 2025 11:05:03 +0900
Message-ID: <20250909020503.117265-1-weibu@redadmin.org>
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
v3:
  - Cover both 8401aa1f5997 (description/purpose) and
    5b5bbb8cc51be (pretty format example).
  - Use 12-character SHA-1 consistently in examples.
  - v3 fully replaces v2 (not incremental).

Link: https://lore.kernel.org/all/20250905032729.2284883-1-weibu@redadmin.o=
rg/
---
---
 .../translations/ja_JP/SubmittingPatches      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documenta=
tion/translations/ja_JP/SubmittingPatches
index 5334db471744..1d1e9622eafe 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -132,6 +132,27 @@ http://savannah.nongnu.org/projects/quilt
        platform_set_drvdata(), but left the variable "dev" unused,
        delete it.
=20
+=E7=89=B9=E5=AE=9A=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=A7=
=E5=B0=8E=E5=85=A5=E3=81=95=E3=82=8C=E3=81=9F=E4=B8=8D=E5=85=B7=E5=90=88=E3=
=82=92=E4=BF=AE=E6=AD=A3=E3=81=99=E3=82=8B=E3=83=91=E3=83=83=E3=83=81=E3=81=
=A7=E3=81=82=E3=82=8B=E5=A0=B4=E5=90=88=EF=BC=88=E4=BE=8B=E3=81=88=E3=81=B0=
 ``git bisect`` =E3=81=A7
+=E5=95=8F=E9=A1=8C=E3=81=AE=E5=B0=8E=E5=85=A5=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E3=82=92=E7=89=B9=E5=AE=9A=E3=81=97=E3=81=9F=E5=A0=B4=E5=90=88=E3=
=81=AA=E3=81=A9=EF=BC=89=E3=80=81=E3=81=9D=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=
=83=E3=83=88=E3=82=92=E6=8C=87=E3=81=97=E7=A4=BA=E3=81=99=E3=81=9F=E3=82=81=
=E3=81=AB=E3=80=8CFixes:=E3=80=8D=E3=82=BF=E3=82=B0=E3=82=92
+=E4=BD=BF=E7=94=A8=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=
=E3=80=82=E4=B8=8B=E6=B5=81=E3=81=AE -stable =E7=B3=BB=E5=88=97=E3=81=A7=E3=
=81=AE=E8=87=AA=E5=8B=95=E3=83=94=E3=83=83=E3=82=AF=E3=82=A2=E3=83=83=E3=83=
=97=E3=81=AB=E3=82=82=E5=88=A9=E7=94=A8=E3=81=95=E3=82=8C=E3=82=8B=E3=81=9F=
=E3=82=81=E3=80=81**=E6=AD=A3=E7=A2=BA=E3=81=AA**
+=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88 ID =E3=81=A8 **1 =E8=A1=8C=E3=81=AE=
=E8=A6=81=E7=B4=84**=E3=82=92=E8=A8=98=E8=BC=89=E3=81=99=E3=82=8B=E3=81=93=
=E3=81=A8=E3=81=8C=E9=87=8D=E8=A6=81=E3=81=A7=E3=81=99=E3=80=82
+
+=E6=9B=B8=E5=BC=8F=EF=BC=88SHA-1 =E3=81=AF=E7=9F=AD=E7=B8=AE 12 =E6=96=87=
=E5=AD=97=E3=81=AB=E7=B5=B1=E4=B8=80=EF=BC=89::
+
+        Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvda=
ta()")
+
+=E4=BB=A5=E4=B8=8B=E3=81=AE git-config =E3=82=92=E8=A8=AD=E5=AE=9A=E3=81=
=99=E3=82=8B=E3=81=A8=E3=80=81=E4=B8=8A=E8=A8=98=E3=82=B9=E3=82=BF=E3=82=A4=
=E3=83=AB=E3=81=AE=E8=A1=8C=E3=82=92 ``git log`` =E3=82=84 ``git show`` =E3=
=81=A7
+=E5=87=BA=E5=8A=9B=E3=81=99=E3=82=8B=E3=81=9F=E3=82=81=E3=81=AE=E3=83=97=
=E3=83=AA=E3=83=86=E3=82=A3=E3=83=95=E3=82=A9=E3=83=BC=E3=83=9E=E3=83=83=E3=
=83=88=E3=82=92=E8=BF=BD=E5=8A=A0=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=99::
+
+        [core]
+                abbrev =3D 12
+        [pretty]
+                fixes =3D Fixes: %h (\"%s\")
+
+=E5=91=BC=E3=81=B3=E5=87=BA=E3=81=97=E4=BE=8B::
+
+        $ git log -1 --pretty=3Dfixes e21d2170f366
+        Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvda=
ta()")
=20
 3) =E3=83=91=E3=83=83=E3=83=81=E3=81=AE=E5=88=86=E5=89=B2
=20
--=20
2.47.3


