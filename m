Return-Path: <linux-kernel+bounces-610838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B415A9399E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404AE464A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1973213227;
	Fri, 18 Apr 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="LwazqKrp"
Received: from sonic309-20.consmr.mail.gq1.yahoo.com (sonic309-20.consmr.mail.gq1.yahoo.com [98.137.65.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE61211285
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990110; cv=none; b=CvYiCFtCI4ol645J1kTaW33VyKDSI7FXOkVkZLvJA2uRkn91MhtQNEWY+/6KPP5N3YeZJynBTycJi8+IeSLx/vifwI0Rq9+IqDw3YTuR4pLhT7Qoa1Sl9qkLkzVpt3uCj1sI2M2mz/CgYoG2aVU24nDTy6OVuRCDx9gPwlvgLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990110; c=relaxed/simple;
	bh=oHAltb2RCAda/KHTxVe6fxcmyWA9v1kKvq8QUwuvyYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5kOlfMriW/x4RGFivqUxe56/1wmK0zjkzG4v0DvV2qmNabiAjfRvrms6I4LpaEo0ehIzp+LDo9nNDR39Htx1AN3NUbacAKP2zeXAcGqFqZMIS8aLIBsqsI9fUhXg5JrbrMgYa4VECk6bzaZwA2SNeYT6ry8Wt3NgCT1BQZawSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=LwazqKrp; arc=none smtp.client-ip=98.137.65.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744990108; bh=Wvm/4YMU9spXuZGQvSVOvYtIyZayWzPpXcdS32wUGT0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LwazqKrpCmLRMWG9K/S44R9RUaHb4LZAIxBlLT6feQfuA3ItkJicvHtwFr/LTIBw5zmR0LuUJUx/NGBUIQ5ufpPWd0D5i4GZK94CNk6vw6szDBHk3kY22kZGD6EeeIZLYx5fZ+Pw/nnQfycPyKr3ZL0Ix8lIyvQboMCk21TFgM4HXIjcIkCekX4pffUTxXChHNQc0JxtqyAvVxxoA6kunko8TyyB/H0bzQaOiQwi0gmJuQj3NzbbfP1qNU1i1ETIKMf2w4vtOw2dnrB3j2F/26Ut9fHx7Yzw2azAFKwjYE7qVEFbm0UkLioF/bnKjxrW0ee4fCSu4WFtCAVjHhsfxg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744990108; bh=QvacDI54r8zwBEVcI5oK6nahjxG9cKZnTCXFV1VLI87=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SBm7hcOpDdABv10UmXFPHGp9Ryncp9ZVPXejx4rFP7hi2lxcHEN6QHMkmSho3+m0pe3uwCWlINGv6PNpszlni42pPlwJKpToREKW9G4qWMD3olH4tezxvhDQoJkXOVsa8ReK0iYTj+odpgD8gNaLqNPSOOG2g81cdSQY/+TYJKaLuV83/Xin+1z6imVZJutkvdO+i4lP55fYkwahnD1NFhihrlRjPswMB6TGsS8Kha/oFEUPsZPrBHgHcMCbKOkN7vflz9fI3CNjOpYvQKMosg2DONPQ/ufQuk0TZoKPqkgGNir+9osQtpRkhTw2KSId5Kg5NfwdEHlF9X0ubM8xJA==
X-YMail-OSG: wezLz6AVM1nTWqp1u09kmuQgqoZuzjwdCt77..xhUgT69.f8gVklIEMfbfJS2.6
 _hTdMJdZn2k45bI3rIj2S6vHt2zuS3To.Vc5LLpPWeJE2fWJ1qjfb5I_KGXsb2RpnnnruYqiGCQ.
 .ll5abp0ed.sT.0elva0Gs339dcsIL8SQ5ZbvNW_MYJbq7IrcnqvltZ8VGnltrVzJQp5F5dcqI6w
 IeAxcYciFtcRGOnu2gNSC5qykbB.npxd9_U4moyQlNk84Kt0mos2Cu3rcunAZA1qOzb4Fjj.5aQV
 77J8Fjn9bYmUIozCv4lKnK1FPxY4hwIP9MpbdZMOY2OSbOzyky3lxqz2qArBr9N9RBZuhKX3WVLc
 kN1v3SjC2h2olBmI7XZGkzKpVGC87m68tAU8X7edqr2q_tH0wj1mG_aNhOYWx_2QkPcKXIYd6UuF
 glLuU1_ODbIdUPcX6RXzWTCA9TjmUfYQ3Z3fzaFLMUKkaLRRF1ZK6pZG1kfEanW1MpbwZ5uAmq2X
 DBzlteXYJmDS04dUDCsoo3AYX9slnOt9hK.Jxo3p5o7iqMk2nhy8aEnO5_iqRrm.HfZjZiEtGUeO
 7qKOL7Rrf.4F6F75rLoDe8_ZcIj.AbZIeNb8y6nE35m6wyFX8rPwxW_rNjpEIA81PvoHp3AfRoF1
 bYzVYAiruCgp.uAAJukXXH5JR4.UZc46ePt1hNQz9TMqXc0r_TpPJQWBU7i7m5O6jxqCS_Pghb6W
 yDVVIlyBIyt7phxABPGA0g.Hn3jsUYVyuiduyWuxgDjY6cDLw4Ro8G8tyFkIuCG7smINLM46R9Ht
 WSlsWxy_5kYC_fmxT.rTkRyUeWVzulHTavURy.8YdAPrHnZ7WcQR.4eeqvmqnk9l3.iMCTMFGbU9
 p0ypWAPzSMSIYKYJYyna_xQ17uCOAUbnhnOYAnYpn9gBM7CWt.VmGbgHK69jeQJCs4XgCpdoJcN.
 ejdof2Srwg0Y1f7FNeLRszvICgziuUHR8gan63pxBICAdlHkNZzH1GVyIXk.lU.PKSpKyIva9yAT
 H5c_AB9UPV6Iv3Spi4XQ_3UWk7yegEGpIF7SoFa53VWqs5qgQEv76r3YKRRwWPwVO2.TEOV2qRz2
 jPF.bmjXkBKYO1UwiSSzvib3OIQJWsPHtwq66cri.HmU2pkbEfuQgeFx3G0Szu7eiOGIqy4PiAT4
 DO6ZnEnHPgmKH5SEZfHnqb_nOWIX4ntJ5C6rPX9sl3UqNSMrTl6zzOqAJsT2M9xisvpJtEmxNX6p
 GJZdFHgAoztqVIhFjW4yFKDzryThIIZSdu0ckP6R2y1wILoKDxhOPiwOHT2SZYiTfyn5v8elmp9h
 T9JGigfDbe2MMdmbQKDo8MlpDblO0z.9ItyLOUY5IFKFUnXdVz5f1oDXXf.V6kMx5.o47Wh53NvI
 kc6qOkDZyFeAajIZdeokOJl8kL8E00ZtycTs4lmNFkaaxjzg0qRMQENqpNNjxA7TXA_7O49dO9EQ
 FcF83f5Dqf.oG8lepSRAstU_7QaLjiOz248xI1JVgRPlBIQMVM.rWMff6D70z2uA3AXdQpBaDieL
 1n.DJ2YCiDc8km6DHXLDr0gqsiJmfjHWpvHhBwqsmVIeNoQ0btawb8Z.E79cJebralVX8O9qN7mD
 26fGkrNQ6muWlUPcXsPqZWQK34G.q0tJyKRkDEfHbYx2_xOt6T2wYFoEJSZb.kFRwp0BgVAJ_5s7
 UlN.vZQFncR6VuDNo0bNF06DW2oTvtkbdaeI7nYr0GW7J4DbDi1j3Wk7XwuEyWUaeQe2mwDGh.hH
 GbNnFuomtBiJsNVOiD75LB_PF.pUjtW7o0xTYOwPtBQmNjQUNAINgWD2T0fEMPfywRGAKLas0ikf
 jjQ9d7PZ4cWOy6NJan3eHizC.VNoka8dBIGAkw70iuoxwva2G.dDZ6bT5OxmfTl34_PbL0Bj5xAK
 yA_umXhfYqAWb1EeE_Oe255ttXkf.0ZnDj3yvzqNW9GAwBvb5Rp5mWvhKJKOgdFzICEG18fgGdO5
 3wvVezovgJGxXFgmsj8a8vpGLKbcF02oiDe4iexKYc2nyB3eggqxr8DKsj4Vx38RrUiR2_1Uxoc8
 FvhiTMxvkxUbyRn6KDUNF9YztVF57LHek2kPOqlosOxIL4m7XrsGIDp0KO6s2F1m0NBj6ElsWkrt
 tdoGj4a9SpxtsMR.C_QnjpOv1epRV4BkE4Sm_31xFxGjTTWJtOQzKp_6ixLCkyNzJauvyQM_.FDL
 IhKNYlIhKRZU8GadFM3TW.EZbR.R1kmo3Xoh_QsOsFdCYNdmvlXVM1yQVi0mP7eEr3TI8IM_qs8R
 C.i75
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 4c9a8b58-6ba6-4f6c-b63b-45bffe4a0db7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Apr 2025 15:28:28 +0000
Received: by hermes--production-ir2-858bd4ff7b-rjtcv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8d9c4354726140fe64c22851ae4eda49;
          Fri, 18 Apr 2025 15:18:19 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: sm750fb: remove irrelevant TODO line
Date: Fri, 18 Apr 2025 16:17:50 +0100
Message-ID: <20250418151755.42624-5-rubenru09@aol.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250418151755.42624-1-rubenru09@aol.com>
References: <20250418151755.42624-1-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As all code referencing USE_HW_I2C and USE_DVICHIP has now
been deleted, this patch removes the TODO line referencing
it.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/staging/sm750fb/TODO | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/sm750fb/TODO b/drivers/staging/sm750fb/TODO
index 9dd57c566257..7ce632d040b3 100644
--- a/drivers/staging/sm750fb/TODO
+++ b/drivers/staging/sm750fb/TODO
@@ -3,9 +3,6 @@ TODO:
 - use kernel coding style
 - refine the code and remove unused code
 - Implement hardware acceleration for imageblit if image->depth > 1
-- check on hardware effects of removal of USE_HW_I2C and USE_DVICHIP (these two
-	are supposed to be sample code which is given here if someone wants to
-	use those functionalities)
 - must be ported to the atomic kms framework in the drm subsystem (which will
   give you a basic fbdev driver for free)
 
-- 
2.48.1


