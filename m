Return-Path: <linux-kernel+bounces-755422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C8CB1A61D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26A318A39F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A233F21B8F2;
	Mon,  4 Aug 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rq5IQDSN"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6291C26C389
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321587; cv=none; b=b0HAMGUDph9Bukjf/MmF3RABye91aHPcwaCCMDexehPX5Mtz0oPOvvLUON/APy8T9IzxnS79el4Q1Lyn6CWBkGpQCn+VOA6tFgrKMsYsaRF6oNUoZJEiAsNQqzP8CmFFl8We1BM4tKhwJM3nz746xb5/kmvQ/S/FZUOPAn1DDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321587; c=relaxed/simple;
	bh=uUkKHgrzOIHi/hAZ3QVzC5pF5jd7+2AosuCKLSA58Tw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PGkCCN4EPNGWyhWdzmUOg/wEaD6eA5kXPhNjmuALRaED48vCAbxhS5WQHQHG+gzwkP5Xa3Wc1MvP3KMKKsOPK80JbSxd+gAdxw1I0aU9X2NcIDhKIPSOCNzSWkg0cddQvOlrzsAf5uvM79eimD0nhgbsnLj6m/xkHEaExuCbUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rq5IQDSN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459d4d7c745so14761935e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321584; x=1754926384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+WopZFLryciAlo72DuJ/q4cJCaS9uxI8zd7Jh9HW34=;
        b=Rq5IQDSNB7YcACR4mOV05Nmkq7p2G2E6a0DWkf4+GjiABncJ48HbiW7dgVos2sPaXo
         JN6qm182WfP4BTGcV12BGfMTQohr8WWWgIXomeK/4fP+q956WZHFZI4+KBFCwqPG/BnH
         64bUy8kr1qKjcTE+95hNTca/FM2TUU4qxNTy2c0ixXWkKVp+oss46ydwHcUlXi4ABYsb
         rZs9Fh/oMEwHBxZ9Swcq0fAnQdt4m1v5aDdFLvn9sElpiKLy2wLSMq2r8kQyGx/uTPPL
         JPfH4pDXP4mV8seRJah4e4keZZS+O4srezSHyhCB27QHYQDroRFMIFx2c5PbhU49fQrj
         ZbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321584; x=1754926384;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+WopZFLryciAlo72DuJ/q4cJCaS9uxI8zd7Jh9HW34=;
        b=kNZojzm3LoLHOl/P/Cy3g1XK5SJyidI/8exQdA/8gT43fhuApD7D3WWW/psHqnRmMO
         3VdBn+TK6DEE/ZGfO+xj3pYr90a+GVVRROSboh/q3PbwQTfRyPItcJJzc2yy0WaV6b4N
         MW4Qow0bA1PPxOXTAhkelCIKxKfuwiibIi1EsgxgXu6a3bwJmwnDOv0fXqh8kexIdS/J
         13sxMC5BpsN7kzeTni8Z8YsOL+ub7CKhhP+z58EVceQS6VDqWgYWmligY8ACdd7wPyih
         IwYxAJmFgFx3yqKTEoT+pe4PtStJqSnn3O6D1kVx19M2AQm7XteWmne1YrBykB5N7SPw
         3daA==
X-Forwarded-Encrypted: i=1; AJvYcCXxppuCTz3P6myY9I/6D0PvRql/qGz/eC8gbHfyqejixYdlv+g7Dx+4KGffLy1glHspv3KMM2HNIjySZN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI+K0MDta7d2uezumWhogzbjpMtZJYEHyTCj8FEHdvXk5v4gK+
	3QeXEUU4FpMYa9glQJMzW2Q3IXFi7jHMn9Ts9amBOORFSKXMnPEjEnsgsq2z2fLBz4k=
X-Gm-Gg: ASbGnctYTG4/1W2juXjlsmhTj77R/HMicKH8+OYP7kFMEwk6YxwrH+nCnkcwX2/lOp2
	Uzte8Tv1O50z3YI/8TsDI0I12M/pLyBRVkqdB2CVMqdjwgbA5SqHTyUQY3e+6TE2hq1n+sTddJH
	7rsdLWc7ihSUGyqIdvqeETh+cXbR5Xk5jCiKioBFTsNyNdWBND0XtWT+bNcgNto4hX0XZohGnZ0
	OXHrI68E5RGvlegmIRc+pkhkvhi3TeaxNIXA5T4Vx4CW8Y6HYhx/O3TgVUdb6s9aIsJvd3bLmrh
	uwmtZlHi8knC0Vt4uta6m145fGL9u4VOCSBEvx2tJAN1TkVZ5pX4TYrpW0WT08l6jEq/IoAQVDH
	lNJCgf/sY8FgDkre6n/X9ypsM16bABehj0UAtr2DsyLs=
X-Google-Smtp-Source: AGHT+IEF8f1hU2BlwQYVtjlp2hUl6tPsOBX/61hQ8UhG3IJs/dhbSFdGfLAaTj/fxWh7CQaq0TRrWw==
X-Received: by 2002:a05:6000:2387:b0:3b7:942c:5447 with SMTP id ffacd0b85a97d-3b8d94cf8f6mr7300794f8f.55.1754321583582;
        Mon, 04 Aug 2025 08:33:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47ca5fsm15664010f8f.63.2025.08.04.08.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:33:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 linus.walleij@linaro.org, jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, 
 Brigham Campbell <me@brighamcampbell.com>
Cc: dianders@chromium.org, skhan@linuxfoundation.org, 
 linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250731032343.1258366-1-me@brighamcampbell.com>
References: <20250731032343.1258366-1-me@brighamcampbell.com>
Subject: Re: [PATCH v4 0/3] drm/panel: novatek-nt35560: Fix bug and clean
 up
Message-Id: <175432158262.3671011.5417242916841349428.b4-ty@linaro.org>
Date: Mon, 04 Aug 2025 17:33:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Wed, 30 Jul 2025 21:23:40 -0600, Brigham Campbell wrote:
> Fix bug in novatek-nt35560 driver's nt35560_set_brightness() which
> causes the driver to incorrectly report that it "failed to disable
> display backlight".
> 
> Add mipi_dsi_dcs_read_multi() to drm_mipi_dsi.c for improved error
> handling in drivers which use mipi_dsi_dcs_read() multiple times in a
> row. Add mipi_dsi_dcs_write_var_seq_multi() and
> mipi_dsi_generic_write_var_seq_multi() to drm_mipi_dsi.h to allow
> drivers to more conveniently construct MIPI payloads at runtime.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/3] drm/panel: novatek-nt35560: Fix invalid return value
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/125459e19ec654924e472f3ff5aeea40358dbebf
[2/3] drm: Add MIPI read_multi func and two write macros
      (no commit info)
[3/3] drm/panel: novatek-nt35560: Clean up driver
      (no commit info)

-- 
Neil


