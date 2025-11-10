Return-Path: <linux-kernel+bounces-892832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D54DC45EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2CD1888C74
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F795306D50;
	Mon, 10 Nov 2025 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAukni/2"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6A30594D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770321; cv=none; b=TxL+z6dwQvVPtLwTV/Hsn1dXbrz+A4Q0V+GFUaz0XYtJTY0mfQj4vN/KFU7vur6Mx5RgeUligimxFounN5E7fG7r5E/Jm1C40rPAPElx/b8bj359hOvy16VrXgfxF7FpATE265ZlhhOQnWxldueAIwTELWPpjIMLYRx/pPwffwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770321; c=relaxed/simple;
	bh=4HeDVWKiziNfcebFIIM97Wm9k+Fo077LKVzAl79w7tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTgVPzQblUAs1EqbLjTGC5WoVTGKvPLlMjhPtUerYmpUgltjCPHe1whYBOWXsWP/TxxyBf0ylfEC3b8H7IRykHPogrxQ8juWE0bVJqglBqiu43xq9tygv0+vIqsJnM24N7Kn5X75LQU0w6/xinEu1KVekY9dyjWtm6qwmCI12CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAukni/2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477632cc932so10688225e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770317; x=1763375117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFon+KFipClv3lYRUS0OwrYjgGodzikFIdGmNqZNBNc=;
        b=nAukni/22dFijDShKkY2rriO0Rpbgpt5noAeteYieWn6dHy5Z4Bf5dNlJsaBPaGJD4
         rRJ+05PzrVp5uotyc+cU+KDt9H8gbeJfnMiH1jTTK7LdXT5E2UPaUcT+x/xttomAU0b5
         6GmQ4+x0z2cMBeEwSbuJbdzl0G6pGa0kj4nOTlnGVuWaD3qcXkODBAsnPR2ARTS/Kbx+
         Hk5MJ57P/Q861vTX4WKeFUorihPBdhpfDQZ77HSe4cO+J2noRCsbBb8kGoI6cX+aY6g6
         jVtOfEvwNumCG43zam94EpBKwxUjscN6xaT++H2jkF5ea2jd5+IByYzciQrwz+21h4On
         AZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770317; x=1763375117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vFon+KFipClv3lYRUS0OwrYjgGodzikFIdGmNqZNBNc=;
        b=aMBN9ndPA+P0ag50eMwZ+r3BZq5obcTdEV5Q02J4NGrcw6/yXaQRdXr61UPDvRqgDA
         jLAZe5crDIf7OFm2pHjATIjou9cxDcTmLCxjKb2+jKUAHx1YPqbFgw0soxv1u2V37dzc
         9lwKoqXABSyOq1K0LAmVdB4oaaWA9kiT2Mo4EydighplAm55iH0WvgEtv0Dq/brmC1lH
         OoXY+zSnZYzkrxcKFPNTMuU6V8jLJT6ygVDtT3JoigyatnQzHQK3IwxloAW0x4uSZD1p
         CMR3gTdF5w4PfxebT7YFaHZ+G0e/0guVnK0pPQnBHIhfZF9cDuGfEHK934VML6ShVtaK
         kakw==
X-Forwarded-Encrypted: i=1; AJvYcCXO5OXKezjpBTBBpxvLv+qo3KuXKAs30cODtG5CkYIdO3Ms3PS4L5R20ull44J/V/E/EFhRK5cHdz+PjQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpCdkXnykClCLxPhcrd+2zswu0P7LvjC7XhYr/qih6IPesF4EA
	e4txyH41GoX7+AZNGrFFs/xPf+n9wRbEhMQt5KxIO9830WQuhnttWKcv
X-Gm-Gg: ASbGncszWDntLCewlUV/33u9eNBiC8LBXExmj4hg3coLZDTwJ3C2IPciSMVKuRxFLcB
	lds93tE5EUt5c8w68x8rvpWvtpxsBXh8N+7+PPGIAFurwQzawY2jVP2OoKDU51cEzgiPzAH9/KE
	ZuT/1k3m4nQB5XzBdc7wfvUX7T7sv3g6xoaxBW/zEnUwYtnTpwOMrfLqQvusT5UtafyQXCR+EjD
	tcUsR/EW9y7Xf6E2J2UXCBZBzqWUErlVdvEohQyJdRguISJQccRSDOwy7t/GgGLXpy3DIOkUvtt
	yA0pnFO2JqctAtpexD531Sga+Evy7yI1AQ/c/WdZYna7pm/e2HjoIcBpgCI8o0OTIVo2Qv+PZTm
	xhh5Bp6mI3LO7slylX6mtm4PGVeCN/I95OJegOD2RcgAXh46sJuuekXR6nzNUgNdXU8W4N19R15
	Ud2TwiWhcNkIBkEa9K
X-Google-Smtp-Source: AGHT+IHSuWiJyodQKxIazZF2GKqAu1vne0DVb+QamurO00ttrLG+PGm+BNqeMF7injphB4KfCgw87Q==
X-Received: by 2002:a05:600c:1c92:b0:477:7cd2:5bf1 with SMTP id 5b1f17b1804b1-4777ce77011mr20942855e9.38.1762770317125;
        Mon, 10 Nov 2025 02:25:17 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm67326715e9.13.2025.11.10.02.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:25:16 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 01/11] staging: Remove gpib Kconfig option from staging
Date: Mon, 10 Nov 2025 11:24:57 +0100
Message-ID: <20251110102507.1445-2-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110102507.1445-1-dpenkler@gmail.com>
References: <20251110102507.1445-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option is no longer needed after the gpib drivers have been
destaged.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 075e775d3868..2f92cd698bef 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -48,6 +48,4 @@ source "drivers/staging/axis-fifo/Kconfig"
 
 source "drivers/staging/vme_user/Kconfig"
 
-source "drivers/staging/gpib/Kconfig"
-
 endif # STAGING
-- 
2.51.2


