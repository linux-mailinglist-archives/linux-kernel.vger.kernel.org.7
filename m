Return-Path: <linux-kernel+bounces-815047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E0BB55E8E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 07:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE40581D72
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE9E2E2DF2;
	Sat, 13 Sep 2025 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nDCInszP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PotKFIAz"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0016C1DD0D4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 05:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757740921; cv=none; b=S9RZm/lX55SlsxFQQV9jLKJdgqKN57L+iThBtLbXfGqm6VVrsYP97mbD+2BSphCoaOwGHbD/bQ3FEXq1hDBE0wduv3pO/wJIBRhEju98dIKzo1P81Kp2UPDi5RtKNnQcePGQreFajBsnKWghMzkNnCQj/Px0sNkT3foY/YmkVEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757740921; c=relaxed/simple;
	bh=EiL/DhGNJsuw8TWp+VAh+P2SCe4332B+IwN32sLp8s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKEkJdfTcdSUCCApKwkEpypMIA3T6s+EhdGQvYcHtURiIIkMCyuBSUA3V7psr7AlLaCIfhH+5kP/NNB3qPJMlNkO7GC7GuySqVYlZPpr4ln/mSGOvsmtdAJAO2RF1cEylCmvTQfSaLLzEl3Czkwk1FkO2JAgiUoc5zu0/9uHGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nDCInszP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PotKFIAz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E7E2EC01DD;
	Sat, 13 Sep 2025 01:21:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 13 Sep 2025 01:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1757740918; x=1757827318; bh=cktaq3vi6+QiWEhOgyfud
	QrPSODKg6pOr7hfniZrmPA=; b=nDCInszP3qlTONwSl+o1k2WggCNFldeqwQX/I
	qhy036AdXI6l+B3NDFA1HPye76TpP8G3kOL8A0cKrUUwezolWz65bRQN0/622yLF
	cig+EZaGdNArbTidaSGbZQ8j0wZQH6dVwNJTfwamqg9tV2PhIJvYA87JUE9BJRiZ
	ZyCNG14xFESjNMPD4xj+uNcX9KjA79toBg1edahcbuCW2qkuBqxZnMrL5mhAuhAb
	pwruJtU/AddAzwZr1SuC5wPrpGjQtyjyV15ULIkehWUQe0c91rxzT+q8dh4cVilj
	Wpy2vQnoN7rh3OEB4PySEqjMuiFecSnIw1Yc4VDY3kDhx6CtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757740918; x=1757827318; bh=cktaq3vi6+QiWEhOgyfudQrPSODKg6pOr7h
	fniZrmPA=; b=PotKFIAzHkCqBRaxewaROMabGVHPnw9CzHn6CIwzfzIHpqaophi
	/W1rVi3qkUP+krKtbKNDv7o7oIO6NxfX6nHWKSTVPKkeyDvicun9O/2lTDZV9xzH
	PzxzIRdTKy+GavRUGVYH2b7nqTXmJv3obQYZkZXo1rLgpOxv18mEeWdxqNQfi0kr
	KKzvhJqd2KHENxdXoIec9OeUokEow5UDs5XykfMta3FU5uu5ItPY2klH+HjudR5H
	9MhvzBBm0TqFT3pKo2GTw8Grt9fFCMRrZZRvt0p3f0g2xCwb7q/Ke3TrTKaDvHym
	bW7plyMvdhPdc0aNuQgjXbot52eT5UjMY0w==
X-ME-Sender: <xms:df_EaETEC2ZxHUmZJDRMaGzwYJpg0kOIwU5ujwTf1N_DKolHIXx7FA>
    <xme:df_EaCYZ60wDaxwlket6mK-QhtJQ6OD0Tsh62-E0qBb0-koH9Ri7Ion5RZZmx5_Vb
    PZgr_gxclWXrdPDjnw>
X-ME-Received: <xmr:df_EaM-oS3JmKBKEOggUm1Prkv-eCFwO8t4k7jg2MjrxuGlgrqkksSbOCwAWtTf3Y4RzQIoQ6xd7j2kq7GnjmDQvzPxo8Hs0W83DGZbzN0ujeco1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefuddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomheplfgrmhgvshcuhfhlohifvghrshcuoegsohhlugdriihonhgvvdefjeef
    sehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephfevgfekiedutdduhf
    eggfeivdeuhfehtdffjedttdefkeeifeeijeevtefhgeehnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsgholhgurdiiohhnvgdvfeejfeesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohephhgrrhhrhidrfigvnhhtlhgrnhgusegrmhgurdgtohhmpdhrtg
    hpthhtohepshhunhhpvghnghdrlhhisegrmhgurdgtohhmpdhrtghpthhtohepshhiqhhu
    vghirhgrsehighgrlhhirgdrtghomhdprhgtphhtthhopegrlhgvgigrnhguvghrrdguvg
    hutghhvghrsegrmhgurdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrkhhovghn
    ihhgsegrmhgurdgtohhmpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomh
    dprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtoheprhhomhgr
    nhdrlhhisegrmhgurdgtohhmpdhrtghpthhtoheprghlvhhinhdrlhgvvgdvsegrmhgurd
    gtohhm
X-ME-Proxy: <xmx:df_EaMnkX9_BzM1hn7sVx7e7J8h7FzBTpPjZwE7Mkw9nxaw3IcRu9g>
    <xmx:df_EaBZfYC6HwZDogcSAPTk8aQD2nQTzmAq_wHb990HPYZvUqDV1cg>
    <xmx:df_EaEPIDyXRVfS9JhHrL0CyyQQWmUcl-aPx6-xuEJLqYixY9Cp5Ag>
    <xmx:df_EaJe07oxiZKvc0aqTCgKB-oPbczexXkXqZCRW8LZAVzYWn67bqw>
    <xmx:dv_EaB-2Kp6Y4uGFk_hB7uVwUzSqzWlZSkXuX_xmPUP2LHAerFQrotjl>
Feedback-ID: ibd7e4881:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 01:21:54 -0400 (EDT)
From: James Flowers <bold.zone2373@fastmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	roman.li@amd.com,
	alvin.lee2@amd.com,
	skhan@linuxfoundation.org
Cc: James Flowers <bold.zone2373@fastmail.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drm/amd/display: Use kmalloc_array() instead of kmalloc()
Date: Fri, 12 Sep 2025 22:19:52 -0700
Message-ID: <20250913052109.2638-1-bold.zone2373@fastmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/process/deprecated.rst recommends against the use of kmalloc
with dynamic size calculations due to the risk of overflow and smaller
allocation being made than the caller was expecting. This could lead to
buffer overflow in code similar to the memcpy in
amdgpu_dm_plane_add_modifier().

Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
---
I see that in amdgpu_dm_plane_get_plane_modifiers, capacity is initialized to 
only 128, but it is probably preferable to refactor.
 
Tested on a Steam Deck OLED with no apparent regressions using these test suites from
igt-gpu-tools: 
1) kms_plane
2) amd_plane
3) amd_fuzzing
4) testdisplay 

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index b7c6e8d13435..b587d2033f0b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -146,7 +146,7 @@ static void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size, uint64
 
 	if (*cap - *size < 1) {
 		uint64_t new_cap = *cap * 2;
-		uint64_t *new_mods = kmalloc(new_cap * sizeof(uint64_t), GFP_KERNEL);
+		uint64_t *new_mods = kmalloc_array(new_cap, sizeof(uint64_t), GFP_KERNEL);
 
 		if (!new_mods) {
 			kfree(*mods);
@@ -732,7 +732,7 @@ static int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsig
 	if (adev->family < AMDGPU_FAMILY_AI)
 		return 0;
 
-	*mods = kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
+	*mods = kmalloc_array(capacity, sizeof(uint64_t), GFP_KERNEL);
 
 	if (plane_type == DRM_PLANE_TYPE_CURSOR) {
 		amdgpu_dm_plane_add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
-- 
2.51.0


