Return-Path: <linux-kernel+bounces-863647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFAEBF8B22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A34448630B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7569A26B75B;
	Tue, 21 Oct 2025 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="WzCL/I7I"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C4B350A0B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077947; cv=pass; b=k1jN86jibhGVh3nfcvcl0fzkknvSmqMwMXxOVOjw6sLiDBeXXmtUM+95ybtdzpo2Zo6ass5FRHiDFmJEzy4W5dud0uMFesrDhrdG3z/T73PYjiYLBs+wvvZYKa8BScYiKHB6FixPFLN1bP04stWdbDX0tPoKvE86SBC1fdWQ7Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077947; c=relaxed/simple;
	bh=fQSr0ohH6ldzOLHdTI7voZvzMcDFXtD4eMmeZzLcs+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OqblLTsp+TStfUvIeHBwlSEzIsmP5QlG83WBxN11X4GXCWmOGeviJ1o0JDToSkk5Qh/vfxBJV6PsjgyM37i/DrqpgOIJ8r4u0OlFuN8Trd3hYYyXE1e0WfyY64UmkrRxf8S3YVMScBLMDNIFOY3luQ22+8sSAeY+57Pq++y/LUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=WzCL/I7I; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (bc043154.ppp.asahi-net.or.jp [222.228.43.154])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59LKItHM026350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 22 Oct 2025 05:18:55 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 05D5F10A0ECCF;
	Wed, 22 Oct 2025 05:18:55 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UMCxPa58udCL; Wed, 22 Oct 2025 05:18:51 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 2410F10A0ECCD; Wed, 22 Oct 2025 05:18:51 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1761077931;
	cv=none; b=lfeThg3CYsn4JXjwm32xuTZQMVpQCont5vtfXxOtgnt0qUfdOSiTBnkmnq75FDUI66hRzJsQ736sReOATElhL3Q6lnuTX3sRI1q0J18NbDoRb71ChCGqHdhS/GcsCqJIBbiY059PEGXKpwYK08EgVTia965a1jNkgKew/NW9600=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1761077931; c=relaxed/relaxed;
	bh=TgHTh1zsRTUhGnDg2RPXn7vAWeAZ5MWHXT2jf02tKlo=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=FKsjsewgw0weHhfPMcPCbE8tXr+YPMVJHeVItzdwhGmmV6Aj9PzV3IvZk2qrIIOge4MxeDxQQpqbMwBqUjY4QnT+dQZbjlWJwh/34AuTrZSuEIPZGDg9hkrPfpass33EcovPmwnkmfkfRKq8UY1uszIv4kHDhYrTxRB50oPRNkE=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 2410F10A0ECCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1761077931;
	bh=TgHTh1zsRTUhGnDg2RPXn7vAWeAZ5MWHXT2jf02tKlo=;
	h=From:To:Cc:Subject:Date:From;
	b=WzCL/I7IYMPKkSSrAOW+I3bR5AWBkKufQCLydGSIJssrcHraazEPNIuDzGcAd+3uS
	 qvW7G3igJ4wlnK9RtbfMSEndKjBgvBSb5WJ2aWWdfQSRXrnuSpuVDmgpM7z8DL//yX
	 T/1yermfrTUABhKjdkd4nT74EUDq4e1a1umkCvmo=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <siqueira@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] drm/amd/display: Fix typo and incorrect function name in dmub_srv.h comments
Date: Wed, 22 Oct 2025 05:18:48 +0900
Message-ID: <20251021201848.311586-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes two instances of the typo "retreives" -> "retrieves"
in documentation comments (for dmub_srv_calc_region_info()
and dmub_srv_calc_mem_info()).

Additionally, fixes a copy-paste error where the comment for
dmub_srv_calc_mem_info() incorrectly listed the function name
as dmub_srv_calc_region_info().

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/=
amd/display/dmub/dmub_srv.h
index 338fdc651f2c..a6f794ef2203 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -637,7 +637,7 @@ enum dmub_status dmub_srv_create(struct dmub_srv *dmub,
 void dmub_srv_destroy(struct dmub_srv *dmub);
=20
 /**
- * dmub_srv_calc_region_info() - retreives region info from the dmub servi=
ce
+ * dmub_srv_calc_region_info() - retrieves region info from the dmub servi=
ce
  * @dmub: the dmub service
  * @params: parameters used to calculate region locations
  * @info_out: the output region info from dmub
@@ -655,7 +655,7 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 			  struct dmub_srv_region_info *out);
=20
 /**
- * dmub_srv_calc_region_info() - retreives fb info from the dmub service
+ * dmub_srv_calc_mem_info() - retrieves fb info from the dmub service
  * @dmub: the dmub service
  * @params: parameters used to calculate fb locations
  * @info_out: the output fb info from dmub
--=20
2.47.3


