Return-Path: <linux-kernel+bounces-869634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DA0C085D8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D4C1C85EBB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BE523BD1D;
	Sat, 25 Oct 2025 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="KJRm4YlW"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E92D1F5834;
	Sat, 25 Oct 2025 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761350420; cv=pass; b=mhTrXM8iLEFvgJ9j6VPvV5nJcUE3QPMxPnErgoeCTPaHngHcN0Rj0aguGk0KnJ9HU4qTUZhBpUZ7zFP/6CV3pQNeNRLJkQGNORrV85TO4ZUFI5n2ECoh08gbwBxGwDhhpetpGJ60n2Nh5GtfWuiOhcnJdFvi5UPgm9qH4OkWULo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761350420; c=relaxed/simple;
	bh=Pps5zQ61IptH/JiYElQ8NB6qsfmhprZKcH6T2bGpxs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kg0kQiDBCouN+/ROe596mnB/AngyqHQvT1v0Edg+SIaeEKcb7dGUyuNlhuY+S9KkErDRb/zlBQAz8c3VOJEq4VnDkA5sq/rz8GdwMCAo++rr3ykuPDWYXtQoCQlt+JFaikVyPX6wxUWjSL8rjd4pXSmKTUroGvEWTuaYsSGqbGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=KJRm4YlW; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (bc043154.ppp.asahi-net.or.jp [222.228.43.154])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59P003Y8071890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 25 Oct 2025 09:00:04 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 83E31119B5354;
	Sat, 25 Oct 2025 08:54:46 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QwEjLo9A5PNO; Sat, 25 Oct 2025 08:54:41 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 3A5E3119B5353; Sat, 25 Oct 2025 08:54:41 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1761350081;
	cv=none; b=tePiV+E594yoD3JRI7mpWkHb+F6O9WZgQQGrKUc9XFxctpcCadQtyAOEQ2zFEmMnIi2qVgopq9BzTajuP2E91syVfmvpcjISRcwapD878K4PzZ6jVGDWySBUM0nP+iuArvyaHj4QcGQa8lod5TDoRFGKgJGc4tcD2Od0Yx0v4v0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1761350081; c=relaxed/relaxed;
	bh=LZ65nPniX8dl2bT2nIt0x3OGLdXFBvLoLJErLJTajV4=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding; b=HeGILTPmo5X06bhG1sOJiuL8xZdWTcC1ln/MyzM+D8MQWCpTWjEasTuWP2f07Qvc4WZil8mnhWbcsJZQlnPhaafhtZgap6kc8KZe7NBBwf+aiilsmj2H7raVEEQSIAXtlhB/xw05cLNhj4Zrb9Qm0gE5oVdA1xwqblHKJqThWk0=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 3A5E3119B5353
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1761350081;
	bh=LZ65nPniX8dl2bT2nIt0x3OGLdXFBvLoLJErLJTajV4=;
	h=From:To:Cc:Subject:Date:From;
	b=KJRm4YlWe4QI/GJE2pFgF3z2buzriptaPqc3yoDur5u6K+sE+L4ku9jrZbMHiuQ4T
	 x7lwajxJhvpn77Xh2en1F+l7YyZiBofYGCJ7I2gDM4Qvpm1N55by/hTsV/VD8u0XMu
	 GHeRwW9lda3z3/FqXML+8xNqxFKIRVEr841/qZ9M=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: corbet@lwn.net
Cc: akiyks@gmail.com, shibata@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, weibu@redadmin.org
Subject: [PATCH] Subject: [PATCH] docs: ja_JP: Move submitting-patches to process/ and add to build
Date: Sat, 25 Oct 2025 08:54:37 +0900
Message-ID: <20251024235437.801625-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

As requested by Jonathan, move the Japanese translation of
'SubmittingPatches' to its proper location under 'process/' and
convert it to reStructuredText.

This patch also wires the new file into the Japanese documentation's
toctree, allowing it to be included in the Sphinx build.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 Documentation/translations/ja_JP/index.rst    |  1 +
 .../submitting-patches.rst}                   | 61 ++++++++++---------
 2 files changed, 32 insertions(+), 30 deletions(-)
 rename Documentation/translations/ja_JP/{SubmittingPatches =3D> process/su=
bmitting-patches.rst} (96%)

diff --git a/Documentation/translations/ja_JP/index.rst b/Documentation/tra=
nslations/ja_JP/index.rst
index 4159b417bfdd..8e01619d4170 100644
--- a/Documentation/translations/ja_JP/index.rst
+++ b/Documentation/translations/ja_JP/index.rst
@@ -11,6 +11,7 @@
 .. toctree::
    :maxdepth: 1
=20
+   process/submitting-patches
    disclaimer-ja_JP
    process/howto
    process/submit-checklist
diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documenta=
tion/translations/ja_JP/process/submitting-patches.rst
similarity index 96%
rename from Documentation/translations/ja_JP/SubmittingPatches
rename to Documentation/translations/ja_JP/process/submitting-patches.rst
index b950347b5993..4bfa84cc705d 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/process/submitting-patches.rst
@@ -1,33 +1,34 @@
-NOTE:
-This is a version of Documentation/process/submitting-patches.rst into Jap=
anese.
-This document is maintained by Keiichi KII <k-keiichi@bx.jp.nec.com>
-and the JF Project team <http://www.linux.or.jp/JF/>.
-If you find any difference between this document and the original file
-or a problem with the translation,
-please contact the maintainer of this file or JF project.
-
-Please also note that the purpose of this file is to be easier to read
-for non English (read: Japanese) speakers and is not intended as a
-fork. So if you have any comments or updates of this file, please try
-to update the original English file first.
-
-Last Updated: 2011/06/09
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=E3=81=93=E3=82=8C=E3=81=AF=E3=80=81
-linux-2.6.39/Documentation/process/submitting-patches.rst =E3=81=AE=E5=92=
=8C=E8=A8=B3
-=E3=81=A7=E3=81=99=E3=80=82
-=E7=BF=BB=E8=A8=B3=E5=9B=A3=E4=BD=93=EF=BC=9A JF =E3=83=97=E3=83=AD=E3=82=
=B8=E3=82=A7=E3=82=AF=E3=83=88 < http://www.linux.or.jp/JF/ >
-=E7=BF=BB=E8=A8=B3=E6=97=A5=EF=BC=9A 2011/06/09
-=E7=BF=BB=E8=A8=B3=E8=80=85=EF=BC=9A Keiichi Kii <k-keiichi at bx dot jp d=
ot nec dot com>
-=E6=A0=A1=E6=AD=A3=E8=80=85=EF=BC=9A Masanari Kobayashi =E3=81=95=E3=82=93=
 <zap03216 at nifty dot ne dot jp>
-         Matsukura =E3=81=95=E3=82=93 <nbh--mats at nifty dot com>
-         Takeshi Hamasaki =E3=81=95=E3=82=93 <hmatrjp at users dot sourcef=
orge dot jp>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-        Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=81=AB=E5=A4=89=E6=9B=
=B4=E3=82=92=E5=8A=A0=E3=81=88=E3=82=8B=E3=81=9F=E3=82=81=E3=81=AE Howto
-        =E5=8F=88=E3=81=AF
-        =E3=81=8B=E3=81=AE Linus Torvalds =E3=81=AE=E5=8F=96=E3=82=8A=E6=
=89=B1=E3=81=84=E8=AA=AC=E6=98=8E=E6=9B=B8
+..
+   NOTE:
+     This is a version of Documentation/process/submitting-patches.rst int=
o Japanese.
+     This document is maintained by Keiichi KII <k-keiichi@bx.jp.nec.com>
+     and the JF Project team <http://www.linux.or.jp/JF/>.
+     If you find any difference between this document and the original file
+     or a problem with the translation,
+     please contact the maintainer of this file or JF project.
+
+     Please also note that the purpose of this file is to be easier to read
+     for non English (read: Japanese) speakers and is not intended as a
+     fork. So if you have any comments or updates of this file, please try
+     to update the original English file first.
+
+     Last Updated: 2011/06/09
+
+     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+     =E3=81=93=E3=82=8C=E3=81=AF=E3=80=81
+     linux-2.6.39/Documentation/process/submitting-patches.rst =E3=81=AE=
=E5=92=8C=E8=A8=B3
+     =E3=81=A7=E3=81=99=E3=80=82
+     =E7=BF=BB=E8=A8=B3=E5=9B=A3=E4=BD=93=EF=BC=9A JF =E3=83=97=E3=83=AD=
=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88 < http://www.linux.or.jp/JF/ >
+     =E7=BF=BB=E8=A8=B3=E6=97=A5=EF=BC=9A 2011/06/09
+     =E7=BF=BB=E8=A8=B3=E8=80=85=EF=BC=9A Keiichi Kii <k-keiichi at bx dot=
 jp dot nec dot com>
+     =E6=A0=A1=E6=AD=A3=E8=80=85=EF=BC=9A Masanari Kobayashi =E3=81=95=E3=
=82=93 <zap03216 at nifty dot ne dot jp>
+           Matsukura =E3=81=95=E3=82=93 <nbh--mats at nifty dot com>
+           Takeshi Hamasaki =E3=81=95=E3=82=93 <hmatrjp at users dot sourc=
eforge dot jp>
+     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=81=AB=E5=A4=89=E6=9B=B4=E3=
=82=92=E5=8A=A0=E3=81=88=E3=82=8B=E3=81=9F=E3=82=81=E3=81=AE Howto
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=81=AB=E5=A4=89=E6=9B=B4=E3=
=82=92=E5=8A=A0=E3=81=88=E3=81=9F=E3=81=84=E3=81=A8=E6=80=9D=E3=81=A3=E3=81=
=A6=E3=81=84=E3=82=8B=E5=80=8B=E4=BA=BA=E5=8F=88=E3=81=AF=E4=BC=9A=E7=A4=BE=
=E3=81=AB=E3=81=A8=E3=81=A3=E3=81=A6=E3=80=81=E3=83=91=E3=83=83
 =E3=83=81=E3=81=AE=E6=8A=95=E7=A8=BF=E3=81=AB=E9=96=A2=E9=80=A3=E3=81=97=
=E3=81=9F=E4=BB=95=E7=B5=84=E3=81=BF=E3=81=AB=E6=85=A3=E3=82=8C=E3=81=A6=E3=
=81=84=E3=81=AA=E3=81=91=E3=82=8C=E3=81=B0=E3=80=81=E3=81=9D=E3=81=AE=E9=81=
=8E=E7=A8=8B=E3=81=AF=E6=99=82=E3=80=85=E3=81=BF=E3=81=AA=E3=81=95=E3=82=93=
=E3=82=92
--=20
2.47.3


