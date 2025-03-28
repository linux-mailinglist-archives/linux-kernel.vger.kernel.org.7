Return-Path: <linux-kernel+bounces-579412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB9FA742D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 04:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FE43AEB59
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 03:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D39211464;
	Fri, 28 Mar 2025 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sqeRiTMn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uife+W1O"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059F211297
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 03:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743132599; cv=none; b=aEIjWTNYQnxCa1MLW2/uJFcTe3OqUaPgqsNqQh5Ou8IZna1rKC5s1INWwWDwujpd/ZXrFoai2P70Rko+PiX06rB5f/FbNDtbub6M/UWuorjzhr1F8s2LTEaGGAYtrZJNrfr4r9EKJdHcEmOeUrxCmA6SzuaKGrJB2RLRMejujKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743132599; c=relaxed/simple;
	bh=8/WxSS8N6A7ADDU4kWFIT2nK+URzk2alNowBMmCMsz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gK1Zmqej1WrwNx0eRGB8yBUQf4MRu9UCJUnSsLsiyiGwWdN7qP5GkaURHHRX3x/Hx8FRjTMzzRW0Bgd5L69K4rjoweFlKO/dnyAUXw/L6Xvkp3qoQpHYF1OZOeVfIf+D07BY4Gcxfxm9wnJ8dxXoF+IIHcuMzhtyGB7qXvwUowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sqeRiTMn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uife+W1O; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id DBCA711401C0;
	Thu, 27 Mar 2025 23:29:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 27 Mar 2025 23:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1743132594; x=1743218994; bh=Cp9lnvxnIv186+PcpNlli
	pcDG9HTXGIBE5DKPJ+XZwc=; b=sqeRiTMnXfM6jqq8DA3k13Z2gwVf98zn/H135
	GS8gXTnNMEJ3MKU/LYrcWreGIEKUUwFwcMiZni9IDYqCYZhiAj3ueNWOxAcNMmb7
	Ukl2I7cZ67Elzju84csRh4YA6sX1eVOYDKtbpT2NAk+B5YRJGx6n6VqqeHdN40dS
	HidgHMy3sQCRd63X0nK5MTmtriUq0yiors1t/3rUof5zEQSiRLm3nwKoZiacKt2d
	iLw0oQOErnrrA4rVzc6A+DPcbFxK8JxJdtMiMSuQgFf64ZkKuZXICOlQc4WhNVOy
	qriyZ4dCHLdSJIquBkhmbJl1hq9Ik+ipiZVHIOBpiAYeHu/ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743132594; x=1743218994; bh=Cp9lnvxnIv186+PcpNllipcDG9HTXGIBE5D
	KPJ+XZwc=; b=uife+W1ONSbhjyAYkKtKCHueaVurosYX+/re1nHbnO2HBb/vuIn
	1FTXGpknr2ycz3RCRjGVfAQWPMZ/srvTeCJsUgCArpalhAHbAfiAS8IOnGu0zTRo
	V9gFqgrt0+2hW6r3W5uKuARubbHjKmpNFYqERgNUPjeL63CdeJ/U4du9DpIDCdx4
	IJC7r8BATbq81tr7NYLrOXokyqPrsUEXXPPZHRczZ122mwkiSCfKwAL+ML7cZ+iq
	SsKvfSue5mzE/woQJG4C9wrSE4EbtJXY6fK28PhDperyE/etyN/bGMbTLKc8bkSz
	1nDslQ+40Fyg1KFtLK3nBY9qfpT2o15rDUA==
X-ME-Sender: <xms:shfmZ0ueZmte-UCiLj_sx71Sr2OicFTeql5p0qIqBCVMLU_0_1YoDA>
    <xme:shfmZxfkAizWkzupd75SCwrdIhPYL9H_qFEoR_wguSR-ayfvcaK9ny6xrVmJA5xj8
    eid39WO4WUuDqlsddw>
X-ME-Received: <xmr:shfmZ_wfvIQvzMU-OzolW59hbrShzUKUYBO8Ixc8e6e_u3BA4Z16pxECoNALr0yqvIRWyEhuy1AK-MiRObQ9K1zAemtGImyIirLvbXcrBxnJUnrX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflrghmvghsucfhlhhofigvrhhs
    uceosgholhgurdiiohhnvgdvfeejfeesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhvefgkeeiuddtudfhgefgiedvuefhhedtffejtddtfeekieefieejveet
    hfegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhlugdriihonhgvvdefjeefsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthht
    ohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghrrhihrdifvghnth
    hlrghnugesrghmugdrtghomhdprhgtphhtthhopehsuhhnphgvnhhgrdhlihesrghmugdr
    tghomhdprhgtphhtthhopehsihhquhgvihhrrgesihhgrghlihgrrdgtohhmpdhrtghpth
    htoheprghlvgigrghnuggvrhdruggvuhgthhgvrhesrghmugdrtghomhdprhgtphhtthho
    pegthhhrihhsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopegrih
    hrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhl
    rdgthhdprhgtphhtthhopehskhhhrghnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepsgholhgurdiiohhnvgdvfeejfeesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:shfmZ3NyCdJM4kDItLzQq4l4PaerQQJfU1PHSdIwvxJs2VqU3G9oIA>
    <xmx:shfmZ0_RIGPuBdhT93TbFw2L5RHMWtEYYUmC9fJ9flovfKCs4EVGXA>
    <xmx:shfmZ_W0wKi7BigvzbvCrGgrVa63VstqKsNXKWcPg6NMpLMzuXKMFA>
    <xmx:shfmZ9e7Grd1sw7Jvos6p3fhNA_7W76JBum0yIg3NekAXL_9jnYMTQ>
    <xmx:shfmZ-d0gZN4Dit82iKkYe5JQ1c7xde-YhBNjDy9ijbxehNfrdVZRCiw>
Feedback-ID: ibd7e4881:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 23:29:52 -0400 (EDT)
From: James Flowers <bold.zone2373@fastmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	skhan@linuxfoundation.org
Cc: James Flowers <bold.zone2373@fastmail.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drm/amd/display: removed unused function
Date: Thu, 27 Mar 2025 20:29:02 -0700
Message-ID: <20250328032942.16264-1-bold.zone2373@fastmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed unused function mpc401_get_3dlut_fast_load_status.

Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h     | 17 -----------------
 .../drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c  | 11 -----------
 .../drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h  | 14 --------------
 3 files changed, 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 3a89cc0cffc1..eaef3899da7b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -967,23 +967,6 @@ struct mpc_funcs {
 	*/
 
 	void (*update_3dlut_fast_load_select)(struct mpc *mpc, int mpcc_id, int hubp_idx);
-	/**
-	* @get_3dlut_fast_load_status:
-	*
-	* Get 3D LUT fast load status and reference them with done, soft_underflow and hard_underflow pointers.
-	*
-	* Parameters:
-	* - [in/out] mpc - MPC context.
-	* - [in] mpcc_id
-	* - [in/out] done
-	* - [in/out] soft_underflow
-	* - [in/out] hard_underflow
-	*
-	* Return:
-	*
-	* void
-	*/
-	void (*get_3dlut_fast_load_status)(struct mpc *mpc, int mpcc_id, uint32_t *done, uint32_t *soft_underflow, uint32_t *hard_underflow);
 
 	/**
 	* @populate_lut:
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
index ad67197557ca..98cf0cbd59ba 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
@@ -47,16 +47,6 @@ void mpc401_update_3dlut_fast_load_select(struct mpc *mpc, int mpcc_id, int hubp
 	REG_SET(MPCC_MCM_3DLUT_FAST_LOAD_SELECT[mpcc_id], 0, MPCC_MCM_3DLUT_FL_SEL, hubp_idx);
 }
 
-void mpc401_get_3dlut_fast_load_status(struct mpc *mpc, int mpcc_id, uint32_t *done, uint32_t *soft_underflow, uint32_t *hard_underflow)
-{
-	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
-
-	REG_GET_3(MPCC_MCM_3DLUT_FAST_LOAD_STATUS[mpcc_id],
-			MPCC_MCM_3DLUT_FL_DONE, done,
-			MPCC_MCM_3DLUT_FL_SOFT_UNDERFLOW, soft_underflow,
-			MPCC_MCM_3DLUT_FL_HARD_UNDERFLOW, hard_underflow);
-}
-
 void mpc401_set_movable_cm_location(struct mpc *mpc, enum mpcc_movable_cm_location location, int mpcc_id)
 {
 	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
@@ -618,7 +608,6 @@ static const struct mpc_funcs dcn401_mpc_funcs = {
 	.set_bg_color = mpc1_set_bg_color,
 	.set_movable_cm_location = mpc401_set_movable_cm_location,
 	.update_3dlut_fast_load_select = mpc401_update_3dlut_fast_load_select,
-	.get_3dlut_fast_load_status = mpc401_get_3dlut_fast_load_status,
 	.populate_lut = mpc401_populate_lut,
 	.program_lut_read_write_control = mpc401_program_lut_read_write_control,
 	.program_lut_mode = mpc401_program_lut_mode,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
index ce6fbcf14d7a..8e35ebc603a9 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
@@ -241,23 +241,9 @@ void mpc401_update_3dlut_fast_load_select(
 	int mpcc_id,
 	int hubp_idx);
 
-void mpc401_get_3dlut_fast_load_status(
-	struct mpc *mpc,
-	int mpcc_id,
-	uint32_t *done,
-	uint32_t *soft_underflow,
-	uint32_t *hard_underflow);
-
 void mpc401_update_3dlut_fast_load_select(
 	struct mpc *mpc,
 	int mpcc_id,
 	int hubp_idx);
 
-void mpc401_get_3dlut_fast_load_status(
-	struct mpc *mpc,
-	int mpcc_id,
-	uint32_t *done,
-	uint32_t *soft_underflow,
-	uint32_t *hard_underflow);
-
 #endif
-- 
2.49.0


