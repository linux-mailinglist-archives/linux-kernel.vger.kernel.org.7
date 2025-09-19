Return-Path: <linux-kernel+bounces-825182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FD3B8B315
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A1A7B5B41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2E6256C6D;
	Fri, 19 Sep 2025 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="tieApSWw"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82811223DCE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758313829; cv=pass; b=Ggy4H6VyvFON3VV9alc5hBYqxoykJINMY3/PNewEVpY49EOGpb+LuYChwyx6m07t+AWcttJ8MntZV0d5cIkih7qazJq+WDho6DM/C94gWUbnJh9puG33o2y52CQuPxb2j+ghaRN3Ac8Nh8n938+C9zgMrMOtNFVN2ddzKRjHcNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758313829; c=relaxed/simple;
	bh=z3bcblvXjYuG16IjhT2FqtcFfGgnHlT8Shqnk7PRUMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EcTVUEZg83jsc7rodoIYkL6zQHHCaYm8khLeScLPp2SKsw3auUY85j+GpiP1nVC8AXknfpRllYp8xkuCHVLjGfSkXNmh92YcMppYoaWdgCj7mC8Bn/myhJao03RqGHdb4Jh0uyXvhizzFNC3l2thPSlXEp8rU64qhCwx+eN9o2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=tieApSWw; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58JKUIWj010955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Sep 2025 05:30:19 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id ACC4D10E4CA7F;
	Sat, 20 Sep 2025 05:30:18 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwR7-27my8yB; Sat, 20 Sep 2025 05:30:14 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 5A21110D40E91; Sat, 20 Sep 2025 05:30:14 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758313814;
	cv=none; b=PlNXfeku8oj2EzYy6qYuLEKpe9FCHDw+GjVqXYUwlc+eSrwIU/mt/B3WUVwsyKvKyTYwMoRMl1QFgFgPj21J4PBKJe8hK5IFAhfo++YZ04dZ6G4BZ0TRvv0kAE/MdO5CcAQNOucxKou63jDyEjeDkN3PIFds90KRKahX2CRZxhM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758313814; c=relaxed/relaxed;
	bh=hDlAW6pRlmwzieurJae1TG24O8nAZARlUukhneCZTXc=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=LvRY3ZAWbrVz9fLC9v49hiB0JC5zIE09E0ou9SrqexR81ahtilQZdLQNIi70pV2tG36Cko+P0tTUzNZta5diINbYuqR486zoSA0lRfxgCcneWyGGWnfUmXpBw4kvyL3XwKTxWX6vyemCU5f8cnfu67gpxWSztFfdOfRLVNowUdk=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 5A21110D40E91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758313814;
	bh=hDlAW6pRlmwzieurJae1TG24O8nAZARlUukhneCZTXc=;
	h=From:To:Cc:Subject:Date:From;
	b=tieApSWw4uiEgzi1g7jJwH8/OsEKYzXnSD4Oo/JsVGVJ5P7aspkZtjlw3c+u02eYj
	 b2HjpiO7knfd3DvJYNfqBt7maQU/TpB+kvM5KVUjtryx82Xkyjj7twluagBab0VHrA
	 R0CAKYRgS4HOIVPvJbPIL0ZmtYHxfxmyYg8JTYfs=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] drm/amd/display: kernel-doc: document mpc_color_caps.num_rmcm_3dluts
Date: Sat, 20 Sep 2025 05:30:11 +0900
Message-ID: <20250919203011.1833355-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the missing @num_rmcm_3dluts field description to silence a
kernel-doc warning. While here, fix a typo in the same block
("pre-definied" -> "pre-defined") and clarify the oGAM description.

No functional change.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h
index f24e1da68269..144de7b3ed49 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -231,12 +231,12 @@ struct lut3d_caps {
  * plane combined blocks
  *
  * @gamut_remap: color transformation matrix
- * @ogam_ram: programmable out gamma LUT
+ * @ogam_ram: programmable output gamma (oGAM) LUT
  * @ocsc: output color space conversion matrix
  * @num_3dluts: MPC 3D LUT; always assumes a preceding shaper LUT
- * @shared_3d_lut: shared 3D LUT flag. Can be either DPP or MPC, but single
- * instance
- * @ogam_rom_caps: pre-definied curve caps for regamma 1D LUT
+ * @num_rmcm_3dluts: number of RMCM 3D LUT instances supported by MPC (0 i=
f unsupported)
+ * @shared_3d_lut: shared 3D LUT flag. Can be either DPP or MPC, but singl=
e instance
+ * @ogam_rom_caps: pre-defined curve caps for regamma 1D LUT
  * @mcm_3d_lut_caps: HW support cap for MCM LUT memory
  * @rmcm_3d_lut_caps: HW support cap for RMCM LUT memory
  * @preblend: whether color manager supports preblend with MPC
--=20
2.47.3


