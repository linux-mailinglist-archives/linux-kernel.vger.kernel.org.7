Return-Path: <linux-kernel+bounces-819342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CE0B59F05
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8995C7AB93C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE000313D4A;
	Tue, 16 Sep 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpQUG3PX"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD013016E3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042833; cv=none; b=g90rQ4gxT6x1ojh+UR6/VGnJw4ZiBzULboDWhGI797ykSjBNTTAijG2R59Idc2RhlNAkV9bkzMJa4z5WalCBk3F+GesuZ2uTxPbzhKdeDKmN2AFhthmtu+FYDVSrZZkFRyf4z4/KfnFwipCLaSJxyGo2T/4nD1rpS8hRj0s6Mhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042833; c=relaxed/simple;
	bh=PRtXFrqG9+2j9ZTtdc5hIyND05mJaNPrt3wyHxjpkv8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mqcULhD2VUkLhcXAlYjRdled7YcBStEFoyKeujK6pYeWx7dB2xzsEKRKJzOvaXiWuVsrag834+o1RGcxKvj5r84+p/kHhRYs+wCkJvixptMnXWGvD6Vb/x3dluOfPm1qOlpAl+ciMNg8VqZITjO+RrUbRd6MqgYVsZ+vaoeUO8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpQUG3PX; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30cceb749d7so2629468fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758042830; x=1758647630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pN7irB1Co6sighopGJF7gG4VawVJzGo06VZPpbBUeRY=;
        b=FpQUG3PXPjEXvrHDaFuvcTAFgdW+Y1DOWtfTdbrud3T0QODLpg6tdNvGvXKrB4om+j
         s8DVZ2QRDN6YXLFILNc7fNqYDpeafwynWGg6NJNyzlLVbyvoW4BJ87aXFPm2wM9UJhWM
         V30NjJWHctTw7Obn5air6y0OviL2FbM3/TzvkVc4nruzNZkPG+akDIV/xvIIk50gS0H3
         t4OEUdIvDUk3H67tQ/nx8S1co94AA6WPDk+RMvQ02BGJLLdhoJ1A+WxYRC3tVfEMldaE
         C9FtntJcEPeWi16CQo2WlEad7szmWrKn2XgKM3F0E02+2giIqE3tZZITa2POyZjm3zs/
         5QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042830; x=1758647630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pN7irB1Co6sighopGJF7gG4VawVJzGo06VZPpbBUeRY=;
        b=cHc44fFpaKcJR+sxKIUsZgVPirSDixLyyqgd4w5hLH5MQAg+YCozxzrvCoVw/oNfyy
         eNwLI1ahOp32mtte1E174BO3SaOgSKD+3EgQseMRQh1QRcu6JXIpuEflgaTPZs7WNd8z
         3Tpf/CK7N4OFFo+6KXpVA1UKt9qoEvF9q+PXbTQ4WIpUCCspUIjEZ7zEcXuW7v9YH1XW
         VRNd/bg730Y8P98CtB3aodlyWpds7T5Tn/alejk0v5MEtWHs1hoPvIsyf3lmDPQ0Umkl
         VSzIjTCdMjVvRmd3TeKkrdsufSdp4wUYJiHjf2NP/tqAWpUxN/7E6T3Ke8cBgIpLftnL
         Jwgg==
X-Gm-Message-State: AOJu0YxxKIfSHMXDXPc8btWphl3Am00RljOJt3D6RKw1oxZi+q0R2sq9
	bqhxEXf2bqzOLqNPENyhUSk9186l7m01DMi8Rj/aP7BXPn3vqTOEVwY6lALvjlHRUJtogrtdc2B
	Z9Fp6RTLN1P3uYHEmc1mdOanjPl6lJ7hH6+zyvXlI3pK5H4Hcwg==
X-Gm-Gg: ASbGncun4QL+HQllUlZ1NHsM5yXOx7ioY8MSKx2ql+FH1QH5sQLFercFozNpRMQDjrt
	WJ8CNRbjKgauylUtQSaHZv3M41r6RiidY+SZNN7bFpACNCclp1kpKigDMi/FzJ/G5ScwqifikII
	AJA7IzaMVTdDR2XgWH94Qferl7QEtbDKnr3idc5aYlGdnDwcK3pzItGiGdJ6VuSJcs5tECVrvCg
	BfzitOcGw==
X-Google-Smtp-Source: AGHT+IHNL7E5MM6ST9Dssd3Uk7kmhRzuACb68kP+b/73NM8zJeNTTvvuZKgwQdXeXhctOHI9VLsSjRnoiBVObEk2GdY=
X-Received: by 2002:a05:6870:7907:b0:333:30f3:cb50 with SMTP id
 586e51a60fabf-33330f3ce2dmr2784096fac.8.1758042830538; Tue, 16 Sep 2025
 10:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tong <djfkvcing117@gmail.com>
Date: Wed, 17 Sep 2025 01:13:38 +0800
X-Gm-Features: AS18NWCd1eg059A7FpVxTIKZFnQrM5d9AywpW_y-j4Zh7xfE8Gq4rjF-eJySaME
Message-ID: <CAMfjjQ1Gtjg4iG8L6Xdm1HP6FmoVgDHC6QhtMEGbA6_y-_6SXA@mail.gmail.com>
Subject: [PATCH] rust/fs: use intra-doc link for `EBADF` in `BadFdError` docs
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: onur-ozkan <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From af7f05e99ed67f57c83e51ca3a1b3010e3e87762 Mon Sep 17 00:00:00 2001
From: tong <djfkvcing117@gmail.com>
Date: Wed, 17 Sep 2025 00:25:44 +0800
Subject: [PATCH] rust/fs: use intra-doc link for `EBADF` in `BadFdError` do=
cs
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

In rust/kernel/fs/file.rs, replace plain-text `EBADF` in the doc
comment for BadFdError with an intra-doc link [`EBADF`].

This improves the generated documentation (so the `EBADF` constant is
linked), and helps tools such as rust-analyzer to resolve such
references from the docs.

Suggested-by: Onur =C3=96zkan <work@onurozkan.dev>
Link: https://github.com/Rust-for-Linux/linux/issues/1186
Signed-off-by: tong <djfkvcing117@gmail.com>
---
 rust/kernel/fs/file.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 67a3654f0fd3..f3153f4c8560 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -448,9 +448,9 @@ fn drop(&mut self) {
     }
 }

-/// Represents the `EBADF` error code.
+/// Represents the [`EBADF`] error code.
 ///
-/// Used for methods that can only fail with `EBADF`.
+/// Used for methods that can only fail with [`EBADF`].
 #[derive(Copy, Clone, Eq, PartialEq)]
 pub struct BadFdError;

--=20
2.34.1

