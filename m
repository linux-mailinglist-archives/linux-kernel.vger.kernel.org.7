Return-Path: <linux-kernel+bounces-773771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837EAB2A993
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9569F6E5D41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360F6322A01;
	Mon, 18 Aug 2025 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsbW9yPo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE45322779
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525582; cv=none; b=TbWYm/52G9RLOxiqb1yDqcN4ZAJZ4qsPnVjvshC0C3oVyjYnpuJSlrV3w2F6YMAsP13Obeie8fhKv7tLW3urkZcJdTAD2j5aOxbLcMjl7dO+KjwJVg43RdgbttQQaxrrMym9oR+OZpvfxcqt111bqQVSK/E+hWNdZ4bWKVNIjWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525582; c=relaxed/simple;
	bh=CiNgOZGMixsgD0/6qrG9yAA2HxAX+DcIvAlaTGUjvLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jDgOZDym0qqS94oOQVPipl0m+NeGBD0ls6xCnEJJWUk0cWLEwsZKhSamvIw4Zu3O1XUlzCymI3eOAjUcK0SJspeMJJ1mtXNkVnWOvjlL3Wc3oLL7fp4q82UqpYAXZopiLixuVeyaKEUPSEcqXTZy1MklSgrRgymZ80abVEvOEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsbW9yPo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755525580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kyCc4a5+AO/yig/KWWz+VAyj7gnO9/iimj/mS2PVAmg=;
	b=EsbW9yPooBa2XTevl1U4flJ3zLWRMWFMGbXtO1gZ8KrhTGJO+s4TFIrANrJ4tuoaneWCeh
	ZqZHacHQ3bKDEzbkjDT/k45/l2rOIRPLAmwNTU0weQHoJbpRUeQN4CghcsKKW5DyDmDiYM
	wLjCvFImVCh3PE9uHGZXhgBvblXDKmA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-_Buovj2aM6K9OsoP0wiviw-1; Mon, 18 Aug 2025 09:59:38 -0400
X-MC-Unique: _Buovj2aM6K9OsoP0wiviw-1
X-Mimecast-MFC-AGG-ID: _Buovj2aM6K9OsoP0wiviw_1755525577
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32326779c67so3943396a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525577; x=1756130377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyCc4a5+AO/yig/KWWz+VAyj7gnO9/iimj/mS2PVAmg=;
        b=KTRNG2N2Uu6pSNG7lWYDN9ZW2NvY4Vj1+g4uLn0m9LbBgCUTcWY1CF/Jk/TUlLnuQn
         VLgmHzNgQHAbQWWMXqilxIZG6RcjT/9DTq7RSaxjZ9RUDX0AM4mEBLAPlrdygDevRfhm
         rkaX2Ksh14r9J9h141sKHuippbv8RwfTQu/A56RoBXpWnKH5lPVYbc35BPoHNd2sgLQF
         LwSPXFFRIwkMQntrE/jRAwMQB/CzjLMgRne/QkKe8Z1fBG6p2VrVqECR93qMn2SMGmt0
         gDCp1ta+t+54uVFpwLtwo+Wsqom2hdYJhhNWsfnViu8TUvlK3refr2kWva54z36QH08M
         KfUg==
X-Forwarded-Encrypted: i=1; AJvYcCX3FWXWi63jm4w7A/XGA4dcRxlwz6qyZ0gFSubEILcP3njFfP46bPuYxOd3DUYP/lTTO5fA5v09mTFlVjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDeFvnO5E9MWFkGivq4h0Le7eP/xRIXso94Z7oVS6eKCJEBGN6
	7e26euatPbjOaXCJsNF5y1htsCeyE4kgl/IrYax2CsGby/OFL5gEgvjqzYg7emeAa2wtNEk9c1j
	xfqwGT44KO4gvnZ7ubxCqgvvn04wMoUDIVAtvfn6xG157G5QHi1THxp6qiY6FW083JQ==
X-Gm-Gg: ASbGnctyuqtxx43lCH1Ues+A4ZtHnVfR+6ey8Tw4afpusuBqLJMPmS7gVVx91Nhkk6d
	4Cjxb8sI6XAZgOsTh3K/423dj0Bex13M34OwLg17BSJO2jnMlABS1TUkcmZyDpEfkl/mu8wHzju
	yGA6q9Ij0xCMdSF/uB6RTmS4udMdYtP69hne/uDyY0FlfWcL5nU4kGcoEkgp+Uh1ph6fmTecPwi
	AheumWPo910ABGM6K0es3g3ML9UqlkdEM9FpnNL67TDGcApNGG6QzAiiBYMvNlIaeNQBhPTDyj5
	tuFu7YRWQMXF7PMkMOfCzplSgBIZi1P6bQ==
X-Received: by 2002:a17:90a:dfc4:b0:321:d071:96a2 with SMTP id 98e67ed59e1d1-32341125b39mr20287924a91.0.1755525577054;
        Mon, 18 Aug 2025 06:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEFZhqlZ8fij0sRgHmfXSCb3Qy2WxDI2YZmEvN4xLfCSTRfJG4cO4WUHjpLbXmfR2jjNnVBw==
X-Received: by 2002:a17:90a:dfc4:b0:321:d071:96a2 with SMTP id 98e67ed59e1d1-32341125b39mr20287875a91.0.1755525576654;
        Mon, 18 Aug 2025 06:59:36 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d60978fsm8269896a12.26.2025.08.18.06.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:59:35 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	lee@kernel.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rust-next 0/2] Add llseek support to miscdevice and samples
Date: Mon, 18 Aug 2025 22:58:37 +0900
Message-ID: <20250818135846.133722-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for the llseek file operation to
the Rust miscdevice abstraction.

The first patch, rust: miscdevice: add llseek support, extends the
MiscDevice trait with a new llseek method.

The second patch, rust: samples: miscdevice: add lseek samples, add a
simple example of how to use the new llseek feature. As currently the
MiscDevice trait does not support any read/write file operation yet, the
sample is fundamental one. 

Ryosuke Yasuoka (2):
  rust: miscdevice: add llseek support
  rust: samples: miscdevice: add lseek samples

 rust/kernel/miscdevice.rs        | 36 +++++++++++++++++
 samples/rust/rust_misc_device.rs | 68 ++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


