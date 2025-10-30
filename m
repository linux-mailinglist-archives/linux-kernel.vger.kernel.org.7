Return-Path: <linux-kernel+bounces-878632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B011BC2121D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B511887A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED233678A0;
	Thu, 30 Oct 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g1FrLXZa"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF893366FB8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841256; cv=none; b=KbR5PAXEqQxSyCr72VskvZ6XF8if8ZIgKUfXdZPyTfJBGnsmBrQgte497xXEARpqAWrur2h7dFDsdNA0ILqxLE5sNr8PCVQhOadUZmjyF9rwKRXAYwqq/ncJTjZEtvJntzw4Oqyw473s6NemMEpenEyxW0ESzlU+WDTvRQo1S+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841256; c=relaxed/simple;
	bh=HOlsI1WL2pUOj3jiIjlUBv5xuoHSBj4TCt/MQZBxo4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXjzqSsB/3OMoNw+YDgGXuBi11q6djKE2/um3ZI6ykJx1OACW8Eaj/DBvAQIdGbbTODXMGe1T0vxY7e1+XQuU2nKd4i6+CY1Ek5AJKPpPM6R9uIpNBNfbgtdzOQfX0bUOXbiAngGS8x8x+dAfFnm23gu5yiZ79To901vQ4dJVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g1FrLXZa; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so774710f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761841253; x=1762446053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxksKMOC0fIZKUeOpeJVdapuRlnKQu02ijU5lY2UL60=;
        b=g1FrLXZaR67nv2uj45/vFz4SiaNRhA9ybLeGDvwit7L8yTiBsPMQhbnR7jdET7sh7Z
         oeKxnrBD4dDGRHQ19s/jPTIemqSAFMJy5J5l8btEsD5xCFNQNYw9StFxHf6+1MGJ02u2
         ydJr5HBDUBC0VknkGcYi0/N5Z2nGxFF/XiXBvgHmZdS1HX8Y2BnfPGF5zjSbmMA2H6xF
         U1SdckkDt5mUh5me5YGGXLf5jZLKiuZidF6EEVWUFIQp3pcrNY3jjRUvamKx4HHMUm1T
         iiym5ic/busJHjTGMFs5r2BS26suIYAXVLY1FCBdguxPSHGZEiPdMQNf/8a7FQavKIpg
         o6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761841253; x=1762446053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxksKMOC0fIZKUeOpeJVdapuRlnKQu02ijU5lY2UL60=;
        b=fDkjW5VnXAE9iHk6sNlScff/nqZjQUdM0lbiYPohPyA89frk0gb4Pnw84BB8zL+OYG
         2Z72EWwJiRXeZyYcYgjSmpPGfZvqwozfp0J0QQc/7NcwySczJh3S/MC7ho2SANYl6NpU
         C5lLH9jxZ6shepm6wY+pttRGVJ8z8cDD/Oh/MsnMFTCKYEvdl47dLJnvlUs2ygpsae/n
         sPfeyf5HOjxNmk5JTcLLjx01ghP20Zw1XDrzrgdPB/rpSiuowGghBG2v2FOmq7bT8jkE
         9gHCEfNeiHs/R87Hm0VpBig+1+/D06iFBYRpbpYFwFo0m7pW2S+NJG5VWPSscRX149NT
         SoJg==
X-Gm-Message-State: AOJu0Yxh5V+TPcS60bH3Fvv1DconWP4X9dJADwyOMaiWsZMQoAA6OoaO
	3yf+Pl+egqZ+ocfZ0ututiM84lgYe1uwTW+V1uTdn4FnDfmI2zsH6Tof2RWsvsY0hW5co4oYD1T
	ESnwO
X-Gm-Gg: ASbGnctvHzEB5E7iJitecb772w48DYnZ1A4D2NAqAnb9/cYOQxymMAeb9/37dWufW05
	r4eI5pvOsUb/6/agC1lDpcUfaV1xe2g0MS9Imy1eBkRS1U5GnwINIB517X5ieoyaWkPieiMiQRf
	YpHKoSNhPGLYMcmlpIc2hQARE5ghXEESbC/BybY/ue5cCaO3Qd/VnN4cPnEP582KJ8JZzPtVBzB
	/9cDrXGx+fRw9C46+6VieY4zEroYCxlrTpu4IHhdyvk0DrnVriPXD7V2nT1ljSrXolK/ZZkVYDy
	qSSRjzaP/ZO4HlIkcTQOEKQ8u911oZg9c4z0UthIba9t4tnvxOiAAKgKEMH3MmdlKvul4cKz286
	PemQ97wEa+2iWnc69urhz9HI8tgMp5CfmfcEvriABGs4B8tUBtyP3VnBw2hPOaEiK5cJ9tY/rR8
	yIYJ8DIBegXN5adhI=
X-Google-Smtp-Source: AGHT+IGUorMh3PHS7NpCSCwVDESBgHpWURsMbI8izhP27/wehUJo+fPmCOzel6gZtahb2PzgMGlW5g==
X-Received: by 2002:a05:6000:2006:b0:427:526:16a3 with SMTP id ffacd0b85a97d-429bd6adc66mr153018f8f.29.1761841252702;
        Thu, 30 Oct 2025 09:20:52 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df473sm32758678f8f.42.2025.10.30.09.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:20:52 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 1/3] drm/atomic-helper: replace use of system_unbound_wq with system_dfl_wq
Date: Thu, 30 Oct 2025 17:20:41 +0100
Message-ID: <20251030162043.292468-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030162043.292468-1-marco.crivellari@suse.com>
References: <20251030162043.292468-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index d5ebe6ea0acb..166085a7e681 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2222,13 +2222,13 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 	 * current layout.
 	 *
 	 * NOTE: Commit work has multiple phases, first hardware commit, then
-	 * cleanup. We want them to overlap, hence need system_unbound_wq to
+	 * cleanup. We want them to overlap, hence need system_dfl_wq to
 	 * make sure work items don't artificially stall on each another.
 	 */
 
 	drm_atomic_state_get(state);
 	if (nonblock)
-		queue_work(system_unbound_wq, &state->commit_work);
+		queue_work(system_dfl_wq, &state->commit_work);
 	else
 		commit_tail(state);
 
@@ -2261,7 +2261,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit);
  *
  * Asynchronous workers need to have sufficient parallelism to be able to run
  * different atomic commits on different CRTCs in parallel. The simplest way to
- * achieve this is by running them on the &system_unbound_wq work queue. Note
+ * achieve this is by running them on the &system_dfl_wq work queue. Note
  * that drivers are not required to split up atomic commits and run an
  * individual commit in parallel - userspace is supposed to do that if it cares.
  * But it might be beneficial to do that for modesets, since those necessarily
-- 
2.51.0


