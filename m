Return-Path: <linux-kernel+bounces-782977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA1B327EC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C65C1B652D3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A4E23B627;
	Sat, 23 Aug 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcD+jAuk"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C841E2853
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755941339; cv=none; b=Z9h+lqSNW0ASLnJCzAT3E5ojnNkX9emz/MQ5KMmcdbbAvBMr+rOwAaGKAKImXFinw0/WIoVXt9RbgD4GmecwO33KOWc6xfAZ/MhiMglDx+Up2FURLUMnKi5nsZ+7b+rcPiu9K8kxRA6A8HFNCddawcnYCBaPs7gX2ohsq9bQG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755941339; c=relaxed/simple;
	bh=NQbrVZtK7bMz/MTMFu5tiS4h4vXT5dVjGI3480OyjHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mJ5444Ago8MaAx+dp9+CL0lGbj2gyuvMh7yW1Flyf6Qaor7wCDhHktwQoktJ7UXEWquNw6pRNPzK5bpOl9eYIBRCbIQE8fZ1uaKu3VsPxdbTh+qIM/pZL6OvvjDXro12UM+O6L5BXBpcw5a4J7Pa8w59LwqPVVfhpgurhXrRbWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcD+jAuk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323267872f3so2339552a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 02:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755941338; x=1756546138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=clYk2rcWxM2aiZ2rBZGHZQJ9PUsfPdIZw87dXlv1eP4=;
        b=gcD+jAukq18U1A/jHO7OwOD2AlXppu3YLnOF9yhL6jVw33/AQh6t9fsrfHalhQC3E0
         8XmSXf275U5MXJqBk9eUyxKJHKEM0jT9qS8rLoEUOssMEXQDShJ5xwv7ucfNeOh+id7P
         a29wDVAqZNDW4R1FWjyX6kO0E03EU0fBgUuHMiw2cUGwdeQHOeVxPa/xQfPQG+3LkOUN
         xfhAcbs1F9+N/T5M9LUuWUnGBf+Uy/SfsaWnaGNHSsVGZ/RiJMsv3hbZyB91OFz1otck
         9yycnlacs9s2DXlg9WE5rzO4V4XUTOWh72TRCaBUfCp+HEVsNu0UNI8dFrZ6ZBID8b+H
         xjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755941338; x=1756546138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clYk2rcWxM2aiZ2rBZGHZQJ9PUsfPdIZw87dXlv1eP4=;
        b=Uzzi8lzalK1DZF0kRZPibLYhAeQLO2ED03NFwHUMOM+FHWyfs43z/Qcg/G51IGjpEk
         EC4KYp8XEvbc/UucAts1z2s/4QHqZPpyUc/NM3k1upQyxw/ExxsL0N6GlbwfsUT9aO2b
         /vQRVJKV34ROsu68Upp4+EQxqhv7I0aWki3IWWIzvI7nmZDX3Ub1smrjFh7e3bcBlt8B
         ceRKk+d0heR322GwR8nHo/WyGb6AE5FvjDiZ9FMp3sV+xmA0vBQYV7vxzVPynyOmszOk
         FEXK9w2hnuKuXq/dMvGtaTcO+Tn6bOz+29LRKG1Aa2mY+1CWvhsulf4EsrvI4NkJggTu
         FOaA==
X-Forwarded-Encrypted: i=1; AJvYcCX0vJFpkEoiRB2o2TE2VViRI+ZuwRLnIRcW9Gk2Sh2SOm/8mmWgkghwWt1gsZluyVEpPmR+csaMWMkSzvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAZkYqWjFkoOJuTXSu3002xJK88oOZPxwAhBwKaUFDF6JLBM2
	vrcKSb/Owp2DosAssi3RLNCDh5Y6HkjI5cVvaXGVrtxuMP3ug8ZJTtb6wGXHviA3
X-Gm-Gg: ASbGncv8uxhv3J9nYASDwUKkLMK9QzZFv+r8L49uZObI6nixCCwfqhII3afmwNoyUV9
	9AhJNPAGzj79UnAfMJnt8lLG0QHtJMyEXGBFe6AmPaBP7hB5aP1QkPKIcsuR3ein40to9H3lNSn
	wTSe4NqYxva+cZVs+JAHazz8fAGmvebnl+PyEdbP+RMgW6lCmkzSMpRs8OuolST74kmB/Lhj0A+
	n4tqWHJN7xfeLzeETqzS7Fh+ciYM5oOnvPe5pQj4aJov7SgzRu0O1l+IpdGfObahsSWmVYDIS/0
	Sl8GaqxWdZbigzUsyUjBUImer2WzLR30wXBndMh59vXoasDFMX40K3OoAs11+5qrKQ6D/vxBZSL
	JQAe9lqNoPvi/opialePcXnIQDw0FjR8T+Xg81XRsNr8yRzbsot2E/pbRZQo=
X-Google-Smtp-Source: AGHT+IFbdmB4ufECA28jr0BbdHbDeThrDWfYx88tyZDXeND12WomMShWFSN6ekn8OmcS9z4QIPyL/Q==
X-Received: by 2002:a17:90b:17c4:b0:31e:6f0a:6a1a with SMTP id 98e67ed59e1d1-32515e12e55mr7616828a91.3.1755941337792;
        Sat, 23 Aug 2025 02:28:57 -0700 (PDT)
Received: from vicky-pop-os.. ([2401:4900:8fcf:2a2b:b058:4b01:1a76:84f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254b9f3a06sm1766630a91.28.2025.08.23.02.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 02:28:57 -0700 (PDT)
From: ally heev <allyheev@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	alex.hung@amd.com,
	aric.cyr@amd.com,
	aurabindo.pillai@amd.com,
	Syed.Hassan@amd.com
Cc: ally heev <allyheev@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: amd/display: add num_rmcm_3dluts param description in dc.h
Date: Sat, 23 Aug 2025 14:58:47 +0530
Message-Id: <20250823092847.53330-1-allyheev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: ally heev <allyheev@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 59c07756130d..87d323cd79db 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -234,6 +234,7 @@ struct lut3d_caps {
  * @ogam_ram: programmable out gamma LUT
  * @ocsc: output color space conversion matrix
  * @num_3dluts: MPC 3D LUT; always assumes a preceding shaper LUT
+ * @num_rmcm_3dluts: number of RMCM 3D LUTs
  * @shared_3d_lut: shared 3D LUT flag. Can be either DPP or MPC, but single
  * instance
  * @ogam_rom_caps: pre-definied curve caps for regamma 1D LUT
-- 
2.34.1


