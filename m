Return-Path: <linux-kernel+bounces-808147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1EAB4FAD3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4E31C27937
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C8F3375D6;
	Tue,  9 Sep 2025 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gAhQzHHq"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F32532CF76
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420944; cv=none; b=MQCzMCRcJ+rJ0cKBAVEF9LP0RH1mMgZnRr3FExVRj6KUmCwfV5xRdiOtkvPisL0B/eVm9MLjvKtEgP8kJUJgpLJ+p6SOFyuHXXP38vcjeR+cwTGmWJsGJIqbBU78TC5UV/7VqdoY4qTpPQsVvDZ/KQhnfGJCDl9ydA3mSqml8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420944; c=relaxed/simple;
	bh=g7JHSuHGS/AHIJO5tkoy9pJ90NfTitkci77slGBCpHc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=J2YNaJCWuhSEMt235zzgg2wb34WobxQV9SOS5wE+amoVBGHirJMPj11DyoPpbGUhDc4WoSkFhZA/gDtvvRgmOogrEvMEpQk9LB8t9Z9Q1PG/RUm5ng+/lA4GU3nXXMt/Hd/q42yuhwKt1W3q9N5RbAt7NEBYxrTF7oABlAadtxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gAhQzHHq; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757420934; x=1758025734; i=markus.elfring@web.de;
	bh=CpBWpuZc6ZyutiATUg0dtQx1F9tJtzbjKRwxXbRjqOk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gAhQzHHqsNmWaSlCmLDReQI9vAVkGzunSlXSP1sOHvpP6edWcdGHkwdVBLb7OlKV
	 nFT6OAaGOV8KbJY0qeMpCYLajfCJJLP15qI8XYTGx2kbX+OBAkuhKbL4cRaiTqGb3
	 V7cmwy/JnaP0UvCHQhuEwZg3ejjezsCcx4ndlc9W+6Zy7Pv/w1bA2eG2Zq6fPJEpS
	 NapuKV0zjfROaPUX/PtQiTnHyFG+Psn6kk8SNkcOj8vZLjJ921IhgH8fjUXO7JRem
	 3EJMaavlMUwsTwMXF5SecPXh0D1e+hYVLFDYZPQ125n2HCiCJ94p3q/hQFaRvjynY
	 je2NJJL+bcAzm9Q34Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRYf-1ufFpO3khv-00J1rc; Tue, 09
 Sep 2025 14:28:53 +0200
Message-ID: <3663eb06-6a98-461b-8fcb-6891165d107f@web.de>
Date: Tue, 9 Sep 2025 14:28:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, Leo Yan <leo.yan@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] coresight: trbe: Use scope-based resource management in
 arm_trbe_alloc_buffer()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dNLxo7zCpu3q1oDWxfEDRc6A8tyRrq6A2bsrf+huJyQ89nUiAwr
 AKahO1IbRxJGRJWIKUgn3WKXm1zwRdUXVKf78Ngj78fUnHqT8YyaVUzx/onJ/KqdYgZX4yN
 0Psdz501XoRw0wCV8DCtlpWCHmQtobycfMYWe/HsKzibPbbRefOSqhuRCTsikZnI7qi/RKn
 F9Si9D3rbplyUCuEyGggg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qG3AonyGvLE=;zmi9bcXCdbFME4Hw8pRXq84g9oc
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 9 Sep 2025 14:20:06 +0200

Scope-based resource management became supported for some
programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
Introduce __cleanup() based infrastructure").

* Thus use the attribute =E2=80=9C__free(kfree)=E2=80=9D.

* Reduce the scopes for the local variables =E2=80=9Cbuf=E2=80=9D and =E2=
=80=9Cpglist=E2=80=9D.

* Omit four kfree() calls accordingly.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/hwtracing/coresight/coresight-trbe.c | 21 ++++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtrac=
ing/coresight/coresight-trbe.c
index 8f9bbef71f23..1b0d58bf8613 100644
=2D-- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -733,8 +733,6 @@ static void *arm_trbe_alloc_buffer(struct coresight_de=
vice *csdev,
 				   struct perf_event *event, void **pages,
 				   int nr_pages, bool snapshot)
 {
-	struct trbe_buf *buf;
-	struct page **pglist;
 	int i;
=20
 	/*
@@ -746,32 +744,29 @@ static void *arm_trbe_alloc_buffer(struct coresight_=
device *csdev,
 	if (nr_pages < 2)
 		return NULL;
=20
-	buf =3D kzalloc_node(sizeof(*buf), GFP_KERNEL, trbe_alloc_node(event));
+	struct trbe_buf *buf __free(kfree) =3D kzalloc_node(sizeof(*buf),
+							  GFP_KERNEL,
+							  trbe_alloc_node(event));
 	if (!buf)
 		return NULL;
=20
-	pglist =3D kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
-	if (!pglist) {
-		kfree(buf);
+	struct page **pglist __free(kfree) =3D kcalloc(nr_pages, sizeof(*pglist)=
, GFP_KERNEL);
+	if (!pglist)
 		return NULL;
-	}
=20
 	for (i =3D 0; i < nr_pages; i++)
 		pglist[i] =3D virt_to_page(pages[i]);
=20
 	buf->trbe_base =3D (unsigned long)vmap(pglist, nr_pages, VM_MAP, PAGE_KE=
RNEL);
-	if (!buf->trbe_base) {
-		kfree(pglist);
-		kfree(buf);
+	if (!buf->trbe_base)
 		return NULL;
-	}
+
 	buf->trbe_limit =3D buf->trbe_base + nr_pages * PAGE_SIZE;
 	buf->trbe_write =3D buf->trbe_base;
 	buf->snapshot =3D snapshot;
 	buf->nr_pages =3D nr_pages;
 	buf->pages =3D pages;
-	kfree(pglist);
-	return buf;
+	return_ptr(buf);
 }
=20
 static void arm_trbe_free_buffer(void *config)
=2D-=20
2.51.0


