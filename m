Return-Path: <linux-kernel+bounces-859521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A5FBEDE32
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84E93E2468
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 04:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58C92557A;
	Sun, 19 Oct 2025 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyRbaPc7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC7A1B4F2C
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760849976; cv=none; b=XRJGjI6U2XTQSB23LFVgXWw6dh1VfutlWtcnKzTEbB0Cu4u8Bv+ac3AmNXdmn2G1XFAoDiYiok1WyCYTmyuSgvt1rU/pw8R4E54UmUFKDdv5t3RQusqcMMsjCW52PqqTTlRH5pr4YAd3lpKBDeLXGOatDBXQXXpDg0LFIwJlfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760849976; c=relaxed/simple;
	bh=Ji9lq+aNwm6hbpBt5h92c/WN0f79IQ5SjMVzwETCTD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ee87MIYCejZ+jZjc/x4KMXKGd6SQpSjo4v5GR00/9RCB1Owv49jgDyZnc+BE8DKB6qbkIU5cIHL27dZ0Ld9xUiGl69tuaP7E85xAaoqUhHweDJ7BDdUvFTu6GCtbc3QsmlOgtN1Eqrxxipevv02BvOLKrhZrN5cBkBEEp2lBR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyRbaPc7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760849973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Rg5wTZhyWXAF3O1WtCbMwsNNr56nuunOEL5hac1nco=;
	b=VyRbaPc7aR6A7o0O9YgP+nNOA89Hpd1eXSQMissz/G/xb/HGwqk8sEEw9jEny4ti3mMVT8
	Wi3eStxytEePDLD+C0uJAuopAxUTWTmgyOF6/cfFAFLJ+lRpmCslK6j5C70R0TbblMD54v
	EKM9iuVdEPhjY1/XogG3J4hmHAoWXG8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-zdOBbYifMeuimoa7qMusZg-1; Sun, 19 Oct 2025 00:59:31 -0400
X-MC-Unique: zdOBbYifMeuimoa7qMusZg-1
X-Mimecast-MFC-AGG-ID: zdOBbYifMeuimoa7qMusZg_1760849971
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c1f435bd6so100517646d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 21:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760849971; x=1761454771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Rg5wTZhyWXAF3O1WtCbMwsNNr56nuunOEL5hac1nco=;
        b=dxN4jMEzaw+UmuUHZL4G1h4tddDIel7P5C/bdUj9liKYPjaDUSAkl8kp/7fsvmcezP
         YQ/d6wf44R0FUQ6sApsAc8aPV9x5zNV5sd62FrR367kniOCv3vn0KRBQUS+xESxIdj+C
         4dsm+PeM16amNuF1gCiWvLD+1/8InhlHgdtje1ugVneB5Mwc3k3bLXg3uNfZyoJ5BTlC
         JHEbMFnqiSk2ZXg0oGoQIyJDvzf/yn3eB8AJI7NpMrm6dgOFlIFxKWo+d1ZE/P7GTSLh
         Ch+qGQdWXjoMBDovNezHg05Z3lsyJ8W6IOTbPF7GyjnaK1OVt85bZTunOEFiQVC0ijPX
         Zp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlDZteYDYlyHo5hymqFmGL2Lof5RY3YFYV2epbTgm/I2bBlS/ioPSq6XFfx1MTjh/SH45gPaO7w1zmRvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznDVi5B+Gg1dfX0zkSpSkAiKasGSQirUfg26TFiTFUS1e5e07L
	L4gZrRFl7vbPPc3E9zvenHKroFxbUnEFXiN0puVaJuD/bnyBEMVvTP6ldEc6o4jzcxrM9MrNpGG
	o70ZmeMJYyeT8nlQKFzlIoAUI4fqRUVq11AS8mmyObz/rO0MMmE2IGqFeu7wnE1jyig==
X-Gm-Gg: ASbGncuI3/76kH+zDoGTOQu9vqjj2Fs4KRgTrV8YvHMD1BqJZUFQrvKj7f+8I4TXLPf
	rIczf8o4jEVFEVA8k0/TvlkYTEron/DuobVhpaXSJiaPphnrgyVWvt6ElHrr0TVvpX4oCdVhcjX
	3Y6c1dlq4iuHtHEm3MC0DMTVjmaA4bi7zfzJI6RPI+OCP3KDdMmoCvIGfXGMy34OVQocj6cIboy
	bbXxyV8SClq84ckQDnTYamg47U0/d50bb3x3qRby9yV86kWAYtHskQD+hJcXjQzKddQrootjeAG
	I0UpP35iiiE1A1ukFYuzkcnbtI122GhTizlhThsbLxjAWpwacfuW2x+YrjrI8o1MYXnTSDF2+72
	GlHlr92Lx6JQm
X-Received: by 2002:a05:6214:246a:b0:87d:cb55:823b with SMTP id 6a1803df08f44-87dcb558259mr36428386d6.51.1760849971353;
        Sat, 18 Oct 2025 21:59:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ0WYFs94koeYN9P9Lx60CmnPlOsYnsSjjwW8eWntBAW+OKyfBWDFQcDFBfZw6XpdAUPZJUw==
X-Received: by 2002:a05:6214:246a:b0:87d:cb55:823b with SMTP id 6a1803df08f44-87dcb558259mr36428246d6.51.1760849970966;
        Sat, 18 Oct 2025 21:59:30 -0700 (PDT)
Received: from mira.orion.internal ([2607:f2c0:b0fc:be00:3640:bdf5:7a8:2136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028ad781sm27154396d6.49.2025.10.18.21.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 21:59:30 -0700 (PDT)
From: Peter Colberg <pcolberg@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Colberg <pcolberg@redhat.com>
Subject: [PATCH 0/2] rust: pci: consistently use INTx and PCI BAR in comments
Date: Sun, 19 Oct 2025 04:56:18 +0000
Message-ID: <20251019045620.2080-1-pcolberg@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series normalises the comments of the Rust PCI abstractions
to consistently refer to legacy as INTx interrupts and use the spelling
PCI BAR, as a way to familiarise myself with the Rust for Linux project.

Peter Colberg (2):
  rust: pci: refer to legacy as INTx interrupts
  rust: pci: normalise spelling of PCI BAR

 rust/kernel/pci.rs | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.51.0


