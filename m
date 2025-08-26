Return-Path: <linux-kernel+bounces-786474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796A8B35A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18483AF0B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED0C3090E2;
	Tue, 26 Aug 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYg7xJl/"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FBE30BF54
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205063; cv=none; b=bPtZHVZapqusAtf1sYC9QD2WTTj8gqHmMfiauGrthiSV14PtUyG+6D+M5O+M4KCAaQjxs4lgGMyB0k0qD1FJaaTn2w3l2hYjBa3HceY0Z80jD7L3fkRpg3fr0seoJRdEVpJyHnhILtPfW0gpxktQUt5oGouhJb5zIudSL26PTfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205063; c=relaxed/simple;
	bh=liM9eRKLATT3ZL6VnM5QKUJlcWgIUIaeqGhZKRX+jhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qu9OjuUM5G+N7C7yeGLrPGCSO+v4VdAWjOoU9y1n0aVgn9GHYy4dgZDNo5EN1qgmTv9wtyuc8gSJD97ipO7xG8wm7fejse5oV4UkbQLXreOXBX/+MujrmNQkImi7HvpCRIZIkikIlXFdQrnWmqojYdrjK4DefsYlLLX51uLZllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYg7xJl/; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3c79f0a5ff1so986457f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756205059; x=1756809859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvqjc2Uq6UYs7NC0gnmnCXS5SKb+rIIaJ71OyXlnaBw=;
        b=dYg7xJl/w6EphD5IBCU41IGuin0uvFH5B2yHxZbFGeJCG9Y2UZPTKFjncNqeAFux09
         xBR0Smcohq4gLYLky64s1lVv+w33SU9vAA9SRHnAn+6z1ndx/KwyKMMKMqz8n4cDJOEt
         R/zmnWr1pQJhtMQGGeHmJDhMDxmW4z8K6DsGoN1xsaTCAEMFTO6x9RA73kDo7uaNwuDK
         MzD2C5+vDWpf/aP5RucluOIiyBnVnVGyenfkafy5II/xPsXuLJHRXZP49SjaCk8Jzdip
         XwB6ufMgPwPw8XL2MQDG2PBl3lTJFD9P7QP3CGj/woUOLGqvtTiVmGtY43RcD7e7VsNN
         vSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756205059; x=1756809859;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nvqjc2Uq6UYs7NC0gnmnCXS5SKb+rIIaJ71OyXlnaBw=;
        b=AsHB4tcHbn9TEKvNZRdk41xDKeWrEQo6Bh/Mfsl7keOz69JyCXZUotxCyl9quQthka
         hTduZPo9m9e8D+16S7arT1tZZOfRP9aP4pOnuY1Fl6+rL+ec35aemDnHL3bL6lcNj/TB
         JIPT3ZKQ/GiQcQG0Ov9nK11CYc+HlZBMHhAGms4EzW2wB0iY3N3J9Ge0qkERzTy00us/
         bI6qUk3T9JnPpYpHkUfG1o4z5ZiRS90loHELl56opwrg+3y80ukpzXPyQpn5uoYw/sAS
         +C8pFuK1KLsiAE/Zg92+hyydpxB4t56eKQWMHKhqOgMDK0dzXZA/ZEOaTwEL8V1mCYcY
         YHFw==
X-Forwarded-Encrypted: i=1; AJvYcCW5QimMzBT/gY2VRPz1bUjGy5IHn1gUU+xWd5J14dE2ywxDdo0IcQgBrdJrEZoMu5wa9N0CNcK2SnwWCmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHUO1AJISBjhjHs6Km/UB37i0KmiJE1CFBPdo4jxMnjvwdYZ4
	oIxGaMAVtDqlby6NddtNP0yIButksPcK+cST563rLZFfwoHdBISPFANAV4PXPgXQzZQuEz2z9lA
	Tb674O7vz0w==
X-Google-Smtp-Source: AGHT+IEhZCUA8cK1zdDsXe3cxZ2YP7l606fJk1sqWUVX0WU+Z/FGkAc6dryPpWOYOCYdSBOdJF7CAF7nuruD
X-Received: from wmti4.prod.google.com ([2002:a05:600c:8b84:b0:459:8c48:6c34])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1446:b0:3c7:f0fb:838
 with SMTP id ffacd0b85a97d-3c7f0fb0c8cmr6695304f8f.17.1756205059144; Tue, 26
 Aug 2025 03:44:19 -0700 (PDT)
Date: Tue, 26 Aug 2025 10:44:13 +0000
In-Reply-To: <20250826104414.2817514-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826104414.2817514-1-abarnas@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826104414.2817514-3-abarnas@google.com>
Subject: [PATCH 3/4] staging: media: atomisp: Remove returns from end of void functions
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fix checkpatch.pl warning on useless returns on the end of void functions.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 .../atomisp/pci/hive_isp_css_common/host/fifo_monitor.c      | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/fif=
o_monitor.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/fi=
fo_monitor.c
index 76762fc0929cc..3caef0f4eb217 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/fifo_monit=
or.c
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/fifo_monit=
or.c
@@ -499,8 +499,6 @@ void fifo_channel_get_state(const fifo_monitor_ID_t ID,
 		assert(0);
 		break;
 	}
-
-	return;
 }
=20
 void fifo_switch_get_state(const fifo_monitor_ID_t ID, const fifo_switch_t=
 switch_id,
@@ -519,8 +517,6 @@ void fifo_switch_get_state(const fifo_monitor_ID_t ID, =
const fifo_switch_t switc
 	state->is_none =3D (data =3D=3D HIVE_ISP_CSS_STREAM_SWITCH_NONE);
 	state->is_sp =3D (data =3D=3D HIVE_ISP_CSS_STREAM_SWITCH_SP);
 	state->is_isp =3D (data =3D=3D HIVE_ISP_CSS_STREAM_SWITCH_ISP);
-
-	return;
 }
=20
 void fifo_monitor_get_state(const fifo_monitor_ID_t ID, fifo_monitor_state=
_t *state)
@@ -540,5 +536,4 @@ void fifo_monitor_get_state(const fifo_monitor_ID_t ID,=
 fifo_monitor_state_t *st
 		fifo_switch_get_state(ID, sw_id,
 				      &state->fifo_switches[sw_id]);
 	}
-	return;
 }
--=20
2.51.0.261.g7ce5a0a67e-goog


