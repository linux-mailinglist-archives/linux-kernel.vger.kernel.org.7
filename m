Return-Path: <linux-kernel+bounces-860476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C19FBF033D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04F71882534
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84A32F658D;
	Mon, 20 Oct 2025 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1RUFl2LW"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A512F6184
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952956; cv=none; b=iyrm9gvBhMuIi0eovqNEFwAXcF0XUVxkpQGWcigEqG7f8SkYPzmY3GmTvtW+TJip1vOIDDcnQHAHTNo7pDsG/qChBhJhFyhweCHvyENBP/QKXflXYBnpwGtojuzPWgAR61ICDGFfcNP9BHxxwkFEc8pIpvh0pHBAhUt+fws/DeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952956; c=relaxed/simple;
	bh=Re+DOU6/e6dkcK3rl4TDT3ox52jxcfPQEvS5zL7tp/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gay7I+j/640UK8c4NBCAO3dDc/0S4Zn8KKWE80AWTDu9h71TsKjfsIJk1whvgyRLPE4pAsNCguVoahPMYcoQ03yzpRXZvXdEozlN1GNf09EKzccRLZuULIa/AfHj+HtjAySuunH0JWfvf6z4jNGxKPXuugJa28NmwrImxKR9pro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1RUFl2LW; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42700160169so2189214f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760952953; x=1761557753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4tqO9Ss7dvk0HhlC8ItWFcBE+vqGHgkt9qscACZJ4U=;
        b=1RUFl2LWMYmE0wZ7SZRuwEEQkImEJTM/VTw9bsGEhkblqTUgPHPnf4W46mqSkmfNMw
         GvrwVA2X6PLl0Cm6eP+J1TuoRC1x7J/tjlQDvu9n4sqYe9E+6tj3ONopelDCWlbUY2d/
         Lg3XsxX69Eiay3qcA3Id4aOS+YQr3PN4hnPXsfFM6ZzSLpuPUkG/YHTIYB4cXkongzuQ
         GBVIXU6mEuVRoEGqQdVETYB1BF3YEzE9znm9WGwtkT+RHfeoylG+Ev5M40cot5HW1AVI
         dnYVHOsSMICSdvLcemgumkWMglHL9naXxH1HGFzPL8Qh3ssB1XuR8tbqH8JDqjfkHoc/
         eKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760952953; x=1761557753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4tqO9Ss7dvk0HhlC8ItWFcBE+vqGHgkt9qscACZJ4U=;
        b=wlV2lF7hWc+IV5NF3U7jWvkESk/d2r7xOUF6CeDt5wrcgZLuAZl9/xKzatoP6gDsOR
         qcOulZAPyCI4DjCx/gjubHYAhmyckAWK9RLE6cuF61xScvqzBWi1JEDOrFO09ReklRqT
         n/mfCw6wc4KzN0Iqu3Szt+WlFGp55En/RWpgNcWGDAeDF7CU8Pa7cTp6H9XgBmXS9XDg
         dwTuFUAqO4MTh1XsFQq3ylc/d5UHZEk0Tlriu7zPp4bmRYreCi3G528hFT/rltRpp4Q4
         A2BVZ/msgvEpK+MFXhW6/57/WLz7DnOIdt1NMyv8Afeq/5caw/x22zLWyLVEmIPSvwyA
         IduA==
X-Forwarded-Encrypted: i=1; AJvYcCXBXr00oSXXofOksaTjn6a19V7zwrs+5sPKaR3vdvms9ZJJj3E3lKXL+ksa/ZgF6zUBvftOgjCz42Tdnq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GzTnCAby5JHQs5lYZOccP4bxtX8l5LFmo8GvmDi58KxXnYJS
	jDfiOYXBjZYQsCHE1bMSF4LcsTOYk5tdL91WDkFqxlEakSRww5ezYJjg/UYURdgXIEwz7u2oWBm
	H1vjBpVMEP6GUtUOGSQ==
X-Google-Smtp-Source: AGHT+IEPdMgaAsWVjr61PyUGcldq0t0ZV5oF0MkmxsMnMiNypMU138b1txPZ8fl/PFCxXF3KGb7789Q8USnSNmM=
X-Received: from wrbea3.prod.google.com ([2002:a05:6000:ec3:b0:426:da8f:f403])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:26c4:b0:427:202:d4d2 with SMTP id ffacd0b85a97d-42704db5b02mr8051029f8f.58.1760952952791;
 Mon, 20 Oct 2025 02:35:52 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:35:35 +0000
In-Reply-To: <20251020-clk-send-sync-v2-0-44ab533ae084@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020-clk-send-sync-v2-0-44ab533ae084@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Re+DOU6/e6dkcK3rl4TDT3ox52jxcfPQEvS5zL7tp/g=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo9gJ07vy/mXgVpdOzBOWq5qGFjx03OJ2lFgfAi
 n22Xp8hhmyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaPYCdAAKCRAEWL7uWMY5
 Rij2EACyfhsJPjQ4ytTfDpEjKd1ocl5UxJUPZpGWrQOsDzjPSSTHDC9vOEsFkkzpAyXeU17d0Qs
 m/3yYJmuQSOsCPb8cV3ltxv4qU8Z75tF/b6lst22W3fK5G8lqSiGblXNW1gx4TgZ757iFAXCvWF
 ciPm3m6C8M8SIqAa99IIaE8oEUPZBCAnisRRPVJ77Me8S7cNE3xSHr79A1sN6s2yxNWmOjKZ7Yb
 GJu5Wh2dWMZBp3N+Uz9XC69a3s4rBRyJ2yRvh8PVAQ4tAkjq4yq5yOIQUl3LJ+O7bnJbeclMfQ0
 lRB3CR8c7lEba8t4rg6naXb/oFC6W46wlVoT9T04sPOqEMUXQZQbe+eTMUlwCWDoPrJjp/v07IF
 zjql0Hsf3HgAq6UAKoiFs1PdrvxC638uoLpVT7guRvlca/JbxR/Syjttxb8NfJzMAwGpNpb7mgG
 1A3UL9bH0iyXJNzd1JhXR9kv2MQK8XnOczxR9/Lnu+ZsDk2DQeWHAQSAtChVD4gObn3L5KX3R62
 ZMeTuFI0nUJRPevoZ5q5D1lNZveSmGuiGAkuk7tDZaaHkeUiEzroKk2k8FugE5A2g2YnpgzH0gA
 jpgdtAV6a85Ru+ZL2g5oGmNYPDwBIrUMS+5LLf82YGg3oRm3qK2YeKhYjVgX60UorqxiABR+V9T CQ9akw67fcYzwXw==
X-Mailer: b4 0.14.2
Message-ID: <20251020-clk-send-sync-v2-2-44ab533ae084@google.com>
Subject: [PATCH v2 2/2] tyr: remove impl Send/Sync for TyrData
From: Alice Ryhl <aliceryhl@google.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Now that clk implements Send and Sync, we no longer need to manually
implement these traits for TyrData. Thus remove the implementations.

The comment also mentions the regulator. However, the regulator had the
traits added in commit 9a200cbdb543 ("rust: regulator: implement Send
and Sync for Regulator<T>"), which is already in mainline.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/tyr/driver.rs | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index d5625dd1e41c8406494b267d4ac560c442a8012c..574b85bbc497f8d1053d16a11f77ecbe2c87bfb2 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -53,18 +53,6 @@ pub(crate) struct TyrData {
     pub(crate) gpu_info: GpuInfo,
 }
 
-// Both `Clk` and `Regulator` do not implement `Send` or `Sync`, but they
-// should. There are patches on the mailing list to address this, but they have
-// not landed yet.
-//
-// For now, add this workaround so that this patch compiles with the promise
-// that it will be removed in a future patch.
-//
-// SAFETY: This will be removed in a future patch.
-unsafe impl Send for TyrData {}
-// SAFETY: This will be removed in a future patch.
-unsafe impl Sync for TyrData {}
-
 fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
     regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
 

-- 
2.51.0.915.g61a8936c21-goog


