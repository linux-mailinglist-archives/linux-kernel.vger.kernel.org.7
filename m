Return-Path: <linux-kernel+bounces-710449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E3BAEEC94
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 04:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E51189EA0A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C081DED47;
	Tue,  1 Jul 2025 02:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="KzTZ8U95"
Received: from sonic311-25.consmr.mail.gq1.yahoo.com (sonic311-25.consmr.mail.gq1.yahoo.com [98.137.65.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD49189BB0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 02:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751338487; cv=none; b=UFKx4dayVas5Hv6wctjXhcd0RMe8Lz2evOdykHVVmXrZz8Wumge/+4V3JsoaSSazt4cFFR+EbAqb/mk9vYw2PE772ojVx4a+wL/VvjZ6MGEOAW3HNifXWm2Y2AmcoUl3NDXfb/3HFoByO1YKKeJDAhrIzrUyY+Nhxh6wpAr1WNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751338487; c=relaxed/simple;
	bh=+nx5SfnPYY1TmpNkq3fgicCzUBKolKXuasFllHvouUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=Dm/QSXr4HCHA3DxfWeVUIi+XZW4cPxseVhwt+SoQ6++VHhL8c2ch4BfSouNrp8rtjQe7ar4D37LZAfLAq0pGT8xn0cZdmOVInoVihJaJP71MVvzXkye+p5AuxO5RmBMxtF5hfwPaHXPxSv3j3zHcx1DJeAtKbaErfPppDCPpDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=KzTZ8U95; arc=none smtp.client-ip=98.137.65.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1751338484; bh=reRy7ZjdApZc/mrnThLZ8wKZ0d9GTHS5YMBmsIqJMxA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=KzTZ8U951ZmWf5x5ZrStePOC1wRMrrihR2bq8P+5h6bccvsLxXtrw9MvtZm/cWSJ/7GK7NnghosV6n76oz/Zbw7I9UyA8UJuWoXJkwc6f9LvUysuQvxLpcxMYNvXDQ7AX03ZHTskkpJI/9XY8wyu274y6ELlGaWppymbNjSIb33QSSR9NLvmFmZv6shzlNbiyBLQEDN2EdrEAzm0/aofCb5b1LdkwFvTo/bQs7KIXmhN67ggoq2QteHVudH7zu+yYRoftdjLlV/2m9OCoiiHIyENjzUYHP+pnM/GYkO39Viq+duVAiXqW6F3rKygAyDRWpOQIEVxMd4aiZ9FJr56JQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1751338484; bh=3zrdllKaXuTawNcVbfoXctmm3hOZaVDt8EYSC/F1b32=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QXnQ/9Yi4h5S5tVuAMlvMh8zjVPM4GWm7WLHRgAYilRxXuO//rOBvjeLWvo0OSxGT0Lf08RUKjGcoNlI/V700yuBdtoZvEEEZ3C4UGPyV5yDODQNjP5VJSOW4QXQxVfQRGWzLxi/IWcxT1UqDwyM/wmJ3mSGkjjkRi6oXCvQXwWLxsdt/r8Bv+1Q44hfbQC92H6k2Th5pyYay3Uh2w9WGtLMEsnRRhpFugvwrUBWofKgkJAgxTBGdOmT0cc6siy6uuexfLxROA0F+IWpDkLgrbh+DyWIppY9CYxCvAmQaynEqPL4RXsDR7WgMQcwxDHwWRlhovBZ9j/gzJgDWAc3LA==
X-YMail-OSG: wmpJ7MoVM1kDyUEbfm16BUAhZGeOMLqVfcKmmrUrUpwwPE9EGwNZMUOiuetIKrG
 .0PuzQ6II5QQGpP_DGGLfydW_ChE9N.q0Khykj_ruLQxaDuYLUb705e3W9wvg60CocN0SWEG7ziv
 ALANlLkMWPhqIkMn5YWFPEH2BxGcsm6xrWTPZRw86UAD014qwURhl3tsRUQr4FxXBXbkZ7PZxGbH
 0XbZl076NjKrf0DInqkEn7S5lXyNaqi6fpUhWZ5bRpFlcxYYsXeAusah4pZTk9R1zdCWWHjEWc1H
 V25A.Rx.14kuTytDVl1WHY2Sovuw6mvfvyjndf25b1C8j.s1byvmkVAKpT6MkVw.N4prERO6FDho
 _vdQcsHkGolR_lvnwVf7VOCwQA.xQb_Fo1o_CzMV95wBBwmKrfY3FKhVyzVQyyKaeVUwnkr8ANB6
 3T23uEJ7g3XtukdJpNowj3KhPfrac8OBLdiy5oeZ_w4TpbJyEaSi3eOB8w8kq_NKOCcH_.QhPcl3
 EqDDkVwLYe914Wd7WrDFuQXmMIWY3MfcrUPPVJIAIB1vFHo3b0GtaVQnfx76ykAoF1J3uxOxbhX1
 BjvSw5es9kcULnDMFtHDcSA2brR6AOvBXrt55Tf6jmqLKixSYFwW6nA8viQa7eDfZY9FxJXW7WmR
 Av3GSdfpnGL.BxoaH1iLqbwJdqqSl5exwBH8X6NF3_kQpIkfYXaBbMz1bQTydLzoRsqK6I_bQ7Dm
 Q0jSEpxvWnjIGfEnEMRpNxTsHyTrX62Fo7qAw9.H1I1S.FwNZ2xbc7TCuCRvyOpdcSP4ch5zYvJe
 ArPUpuAmqNg77AwHr0WdOTbnYsyM_pgAvxAd4vQsEidukY_iWFIPnd..QEkl9VIWq09sfiI3XDRw
 L1VpAF14w191maBZ93EJgIzs.7cUFQMORQ64uFZPEsuDpRcYA8xkZwsgL.jGS4jcL4q0thSs32ZE
 TeJceaG7xoY1oN4CBebJkpwbVCwFrA781YDuW4.CbQYupMRHp6BG6EVODUIFGqu7ETCNak1NVTmQ
 kJ9n22tBBYAAnkXYEBdkYa87ZMoFNRnv97MUlMWHxU6XL2pcocB8TtAeMRxKqQkoio2weesINlQw
 ce3x.pCPiSR0axMrq7cyQ6kJlQE33sR0a4HC3z95qvhlnKU1Vo5sQ5ku6Ykrh__YfJX4fm3QQ1HI
 p4F6e8RtrqvQjydJGO8PGXSg8sYNW4BokNrF0B2azC7fg3tAHSbcPcNmZNKfrZEjACcyG3CzKbm1
 tcSKqGo0jR35GUgVRUYujxW0t8U0jfUd3lN39y2qdKeZYuW25ty8rv9fBH24a7EUs930Fm_ziZEa
 jGzSTMOe_.Q3xySnVvvqR6GunNRlbdBxIL4tXrAjqniEG3jgEF.jHbIiTcEiZNG4LQGq1TiYQ_Di
 tIl5dpkQUn8Pa5QZtUdwpMCTvkmBAOduahnYx3lgKnC195IjRVROZZF6SUHMjhx7dGrQLJrR40ct
 kGp.XeUj_lxPvf2rTRtvjnHd0MblWu3yc130UMjNwyfDNMoD2gDHLvXr2wzFfys84YkMBEEhE1nz
 0EaqKkkVAaHdR08OcIhZXqO7wL61ncu_A18t1IBn_fgMpIvJiVQQJYichIGhOgh314DpncoPfJt4
 8kqj3_DXS3HqUb6fMlBict.z2D5HqTc52Swhp59cptY4Yr7AhcATTWbHtJG6WLB4OhDh84p4Wn1V
 D9H5dobsIx4d7ip9a7P3cDcfjOa2eCxLxhVYcJz8N320hQLljELuUHlBzJXACsttELuUXTzZDQgk
 gvw1kBoa23KbVsZH5KpgBesmIeVMVaNTbmjzpXPfuwck0IsxMNfN1NRmp0_knuRBV_WpXwiBlXx_
 p62DUn1EOTtmmt9aAAej9M1O.b2xkX26Axcp6ifXtruK2LFxWCk7xmi2fCbhXcDk9fwfP30PWQKq
 zXppaC.ERgo641dugytIvWoibkujeiVDNb8tkn81xZZOkSeagZ0pLaMhmbF5nv6eIEmQY4x1TMUp
 Q8HW_qjImhWhpNDpckiA5J7zTLmzozxUpJ.WmncXBHqu79msmt3QOR7ZIt85eIVQih4CV8Hio0BA
 5uaVy1JyyNeSRwmY1ghDC2agmSmU9mzIaDoUlRl8BlQkxMvC0Soj3Yg6rRapUe.6sX0JikK5xIsr
 Kg6rwfxUtaZofpRvE2eMlW2dJs0SZn9chOHcf2AAud3HSG4u.rkQrS3E3XQGuKRqN2rZwEhTIf.J
 uILVNWk38nklNh3WjXBnza9vvtPRV6d7CpZtzULckQwgMAUqD2djWGCapCeXtRQ_CcBaNxkgPvn.
 L4tU-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 7acc6077-ae89-4b04-b5c9-6c2f2a16046b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Tue, 1 Jul 2025 02:54:44 +0000
Received: by hermes--production-ir2-858bd4ff7b-xdmpn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ec51a81fddb2e4c642e785fceddbcfc4;
          Tue, 01 Jul 2025 02:54:39 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <arlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Ruben Wauters <rubenru09@aol.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/i915: replace DRM_DEBUG_SELFTEST with DRM_KUNIT_TEST
Date: Tue,  1 Jul 2025 03:50:23 +0100
Message-ID: <20250701025426.262129-1-rubenru09@aol.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250701025426.262129-1-rubenru09.ref@aol.com>

DRM_DEBUG_SELFTEST was replaced with DRM_KUNIT_TEST.

This patch replaces the select in Kconfig.debug to use the replacement.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/gpu/drm/i915/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 1852e0804942..b15b1cecb3aa 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -50,7 +50,7 @@ config DRM_I915_DEBUG
 	select DRM_VGEM # used by igt/prime_vgem (dmabuf interop checks)
 	select DRM_DEBUG_MM if DRM=y
 	select DRM_EXPORT_FOR_TESTS if m
-	select DRM_DEBUG_SELFTEST
+	select DRM_KUNIT_TEST
 	select DMABUF_SELFTESTS
 	select SW_SYNC # signaling validation framework (igt/syncobj*)
 	select DRM_I915_WERROR
-- 
2.48.1


