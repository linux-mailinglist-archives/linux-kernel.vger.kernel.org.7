Return-Path: <linux-kernel+bounces-814486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A58D2B554A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F337C576E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266A31AF2A;
	Fri, 12 Sep 2025 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="AJu9X8po"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672628DC4;
	Fri, 12 Sep 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694388; cv=pass; b=avnI1PJ5gVQKCcfHXFvgspGWyCCokhuQka1gW2wmV4YnIIANjuvTIYt5hHVyq/jI7ie9E2px4r/pGQKLrLAUsf5cOHoaf3jMnifRfHu0ZanNfn7QUBvZD+Su4St0xf/r8P030RQfVz3m7RfgBMdh8dEfXIZo8cOIAeZJRqdSReY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694388; c=relaxed/simple;
	bh=hpDe9fE93rsmFC35xNys/eTrUAFLjdsidKVFiOB1nKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUvD7atsa8s7LoCM1/rpQbTB5Ef8wG1+KUlG58IXwsPK1HIkCaXTqH2EclpWdWsP9Nsh2a/683BJ76DMZGxKV+GiZia2wkK1S8KUxoe1oZO3dhSoO6VJ+d5Qt27w7ZbyvL/WDR3PauUBoRAvTU6e9XrjVBbO+5ZYFkJxZdysZns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=AJu9X8po; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58CGQKIC007337
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 13 Sep 2025 01:26:20 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 3A1C1109F7118;
	Sat, 13 Sep 2025 01:26:20 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YqOTH_0wMBEW; Sat, 13 Sep 2025 01:26:16 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 2E6AE109EFAC6; Sat, 13 Sep 2025 01:26:16 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757694376;
	cv=none; b=mjP82++w9kfX/bd8a9e8qSy3ljJhVXWhD53lMfUeX6zsqkPrfWOwLF762GHcZLrtdIQODoBs4F2h31LiA/hRBllIlZH/yFGL7gVAfXT97N6aNeukCpMRFpzevOpN0yvwddMxc6m1+pI/E+mLJcCGMjjq/8LcnvXomCyntZ2dzTU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757694376; c=relaxed/relaxed;
	bh=vT6uI+T6eh6+hI/izGQv/S8WKXxiCdDs9YgrUQqOuUg=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=dt8BnE5aslzEyCpU7nc5tBqsJ8cm8DsXDPwLcshL5kPKZwwdBx92LNT4P8c9ReuyCn1H1xzjR4cu2RM8d7TLbgEbSUTzuRSSJICdWbo4vEn9l/d9IeDvx6xF1JoqYY8d5MiiS8U76Irg8tHubk3eYaJvmY66wWEArK8x/4uUOyA=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 2E6AE109EFAC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757694376;
	bh=vT6uI+T6eh6+hI/izGQv/S8WKXxiCdDs9YgrUQqOuUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJu9X8poiJfzl/o2oKrPu1bESzZufdvrJEeJQMnB/WtD2tzTH4LLG5wkdduemsrQL
	 aUN2rFmq3h/pVR8sFL0O6hKA/K2CgOVvYq2u9mQBJjjjh+7g5u5sdE4UuXtPqQFBD7
	 EJQru+vxmLnjNrTyTgsX5R+byfKq+/6z0szaqMV8=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH v2] staging: rtl8723bs: hal: put return type and function name on one line
Date: Sat, 13 Sep 2025 01:26:13 +0900
Message-ID: <20250912162613.776769-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2025091233-showman-dill-3d17@gregkh>
References: <2025091233-showman-dill-3d17@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make the function definition of phy_StoreTxPowerByRateBase() follow the
kernel coding style by placing the return type and function name on a
single line.

No functional change.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
v2:
 - Keep return type and function name on the same line (per review).
 - Drop stray blank line before the opening brace.
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/stagi=
ng/rtl8723bs/hal/hal_com_phycfg.c
index d5649e7d8f99..cd76e26e868f 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -59,10 +59,7 @@ phy_SetTxPowerByRateBase(struct adapter *Adapter, u8 RfP=
ath,
 	}
 }
=20
-static void
-phy_StoreTxPowerByRateBase(
-struct adapter *padapter
-	)
+static void phy_StoreTxPowerByRateBase(struct adapter *padapter)
 {
 	u8 path, base;
=20
--=20
2.47.3


