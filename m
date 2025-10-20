Return-Path: <linux-kernel+bounces-861383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA3BF296A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AAC74F3854
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FBB274FC1;
	Mon, 20 Oct 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4KYG/2L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27533221FCA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979758; cv=none; b=aFxiRpo6TUM5Zqjl4zGifseBd+Eco+fleJjKB2TflvX9cb2CnGSGzyMUU21UZLHqK55ErejJ5ALph3YdlcQ+WF4mTb4o9tWWff6/rHoxvX+IAozERd6aONlHTUElz/NHMsTx3vKqedn6m1+8ATVjEhbGD4V4vwuwolTvXgcT8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979758; c=relaxed/simple;
	bh=v0g3ebAkGtWaaXXSBYZkhOaLL8t5bHd21ygK4QtLRCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBEBc+VSw4S7gybixLOowpbQfIPeV0AtS3e6a8oJKKJ60pv8V8RNAgbPGEtsYv13n0Y44inoL1CkDB7BZW9Ms2GWrCtGr2UYKvHhTjbHGi762Jy47OVWnLXM+hxiyLdCsiRMIWlGGC0vAlISy8O6W8M6bW6PartGa+ooSAcKdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4KYG/2L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760979756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H/rLXs19LjWdxvoKTER+8Z+MHCSpaGRowtI4SJ2kq6A=;
	b=T4KYG/2LCM84k93YR8b8nvJWoUvSjsH1SKWAjqh0bbw+sQvnc0hj+enxypQk6l4wo560DI
	F7QuqG3rvemBUk0bW0M5fwSV+UayjakuR190epTwW8BVpg6q7EIjtH0HvxVDc69L59MCrc
	S5O9Ve3t9o7aXPKm8KD106o28SkUSu4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Tufc12CSOZC580k0uADYqg-1; Mon, 20 Oct 2025 13:02:34 -0400
X-MC-Unique: Tufc12CSOZC580k0uADYqg-1
X-Mimecast-MFC-AGG-ID: Tufc12CSOZC580k0uADYqg_1760979754
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-891215d399dso1005265585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979754; x=1761584554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/rLXs19LjWdxvoKTER+8Z+MHCSpaGRowtI4SJ2kq6A=;
        b=MsksriyHyWn+3bLvlov/o/JxikC5uOyuAfYK5qXckIS6DtneaUuTkSUd346PNbJhsX
         JM6VrTMdN/13eoyw7QF0Fzulx9LDw3aGVrf67e93f+1FNSPm8FA40WE7Fs4Cl5LLSVTx
         VTMMZlkBKNV79h/JOVGE7Vv6pD5m376dd2lFhpnaknJcc/aJPJIv/TRqSJlpnUA55yXB
         lLudiRghFe45If4I+a/wCCVbJb6DzG0QsDCPZPvST1wwyZk5h+VesCbgw4LBCUyCRoD4
         aV0n5TmkRJQ8OTxnwS3TWTfy4d86MNsJc01FF+ZxEkKkxjiEq6kcPHRwGCeEVynQ94GF
         UppQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrI2dDa5YpBw01lQCPV+pJzBE/8mPTlqi8jYKN+/pIY/HiOHB97cC39ZKOgVaNqPlkdapeNR+/ldzxs7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ksF/nslkUpybqCULpRvcVJPZcI2DDgEUZgqeWS7DmF6nrWls
	J2cncF1FF6eVMWtbc1v2Tptx+1tN91K13dewMxlmQOcFCpiio8JUozLEdfTYqgeoqvklxlEGioR
	AKesIhVDB5ecFMuSG5JNvvZmn5HPJXyX5E2U38aQrq7JJE8ezEYLB7e6wdcp1LVwG6g==
X-Gm-Gg: ASbGncuTjP0AfKHkoU1hxpMQhUNb7Ti6kSHnkGivFofQCR2Hes6ebRJpqk3dDsfnTS7
	6ZOSo9Cv1h/u54QJ/KTNoNPyrNHraaKEj6wImHcFJT5XpR1hr10yl8o956z9234mUjjXYW84JDu
	Z7ED7agoI//3MuDz4VVzr1dtl2JIbGsHcYYgvI1WpXgtqeQXKY/AeMGe7CXnFMpujJezX93sqCL
	OeW6TkiNNiX5ByYI+XF7qCcWIO5c+uBu2vHf/ALQdMnL3zOrbe3la/AlhZw7VfsHPaCxAwYYJD/
	xxqh0dz8q8CppQrSqsqpQQpfsWIlAps5nDNj4ojzn8qyTpocCZK3KDDpocXvBAhxnCYXyKjeCGD
	KYTA0CNpXmb9m
X-Received: by 2002:a05:620a:258c:b0:7e8:46ff:baac with SMTP id af79cd13be357-8906e4ba3d0mr1771876085a.1.1760979754339;
        Mon, 20 Oct 2025 10:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUXXKot6xR6N+YJ5vl0QrsU4HJDgE4R1Ck46voAMrZRdvKXcRoOYSOIO7z8IOJqZtMhnHWzA==
X-Received: by 2002:a05:620a:258c:b0:7e8:46ff:baac with SMTP id af79cd13be357-8906e4ba3d0mr1771869685a.1.1760979753864;
        Mon, 20 Oct 2025 10:02:33 -0700 (PDT)
Received: from mira.orion.internal ([2607:f2c0:b0fc:be00:3640:bdf5:7a8:2136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58eecbsm589945985a.49.2025.10.20.10.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:02:33 -0700 (PDT)
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
Subject: [PATCH v2 0/2] rust: pci: consistently use INTx and PCI BAR in comments
Date: Mon, 20 Oct 2025 17:02:21 +0000
Message-ID: <20251020170223.573769-1-pcolberg@redhat.com>
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

Link: https://lore.kernel.org/rust-for-linux/20251019045620.2080-1-pcolberg@redhat.com/
Link: https://lore.kernel.org/rust-for-linux/20251015182118.106604-1-dakr@kernel.org/

v2:
- Rebase onto driver-core-testing to follow "Rust PCI housekeeping"
  patches, which move I/O and IRQ specific code into sub-modules.

Peter Colberg (2):
  rust: pci: refer to legacy as INTx interrupts
  rust: pci: normalise spelling of PCI BAR

 rust/kernel/pci.rs     |  4 ++--
 rust/kernel/pci/io.rs  |  8 ++++----
 rust/kernel/pci/irq.rs | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.51.0


