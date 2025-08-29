Return-Path: <linux-kernel+bounces-792453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FB1B3C41F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD8EA61CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791432A3CE;
	Fri, 29 Aug 2025 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="bjGPdFGc"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C671EEA49;
	Fri, 29 Aug 2025 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501939; cv=pass; b=AAbAwT8TGPwuFhk64o6YIarkx9bnqAu+R5bahiz4bW8xFZ6n+4T+/smt+kL4yqB12LPR0G7JAwCjvxTRHapHZnVwRuWSRGptKF45pKjiRgjr4oNatb1TPNyfsi6g1KDltTy0Hf4kg626jkBGr7GqV8Z1uBxGYJFrW3Yl41P2tbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501939; c=relaxed/simple;
	bh=CalVgdht99frysxKPEikzeuMUQwNVyVgH+qjUjFlnVk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HARQNX4vFKCVqoKgfNl/YXXCXQV4WXve81ZbPOopFLgOAtp0gjJUcRym3Hlf4j4DaaCOzgeuobwO16tLV7LvcuflijkYeMURrvhX9aa2eBecynOWtnnqPwBQ+EQdNr48grwL4nq/WPmKKbxSGCjdfyTJ1o/1SeyY3FNG28wnVS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=bjGPdFGc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756501919; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KLopBJ52jFL9I9ecFlnrZPQvavdJ7Y6mbo3kkxcqD+bI9dPkB+DevNnzP7cJCfyuMm1JpxEkgeDnNicuA5AfO+1Q0AlJUAhZomb7wRJTeUTWqEO9HB6amPrvyj1wrD1SpzTdWRXqCDHTQC+fZelOxChm3oCnzE4c8FEI21e6UZk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756501919; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3wDH47CXsckGLlcFF3qPTlFrFpWfpYkVkmMdGsazJNU=; 
	b=Rj8C0ye4FCILA37cxISZZVZ1u0wJct7PEuHc5Jqcr4FStqz70qpDlk/9R5O8Yw9fisc4EjTluRc/tvYRLsLkWN/xDJYGGKprj/LANuHe2eOEijeUZ9KPonJ1G3KxPqFQGYcRM4/ST4PzGhMAwq6+E6NnpLCvOJz9264t3rVTJ2o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756501918;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=3wDH47CXsckGLlcFF3qPTlFrFpWfpYkVkmMdGsazJNU=;
	b=bjGPdFGc0nEB0iBtaFk14ChkUhx3scqlL2APvYI64P/L2mMTHKg7AH3X8Vz5zctJ
	Zu7XtPAyhCcH0f2Xs3+0i9Fn5haeMcroEytExzezD9QJaqMB9Cuwf2Ut5Hkx/kVW+Uf
	ScBle+xy9cVRYreGS/Q/zHS3VPlzXlBh+faDvNZk=
Received: by mx.zohomail.com with SMTPS id 1756501916159253.46296982869592;
	Fri, 29 Aug 2025 14:11:56 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH 0/2] rust: regulator: improve the ergonomics of Rust
 regulators
Date: Fri, 29 Aug 2025 18:11:30 -0300
Message-Id: <20250829-regulator-remove-dynamic-v1-0-deb59205e8e9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIIXsmgC/x2MQQqAIBAAvxJ7TlChsL4SHcw2WyiNtaKI/p50m
 znMPJCQCRO0xQOMJyWKIYsqC3CzDR4FjdlBS11JoxvB6I/F7pEzrfFEMd7BruTEpGw9GCedGiT
 kfGOc6PrXXf++H3iLgs9qAAAA
X-Change-ID: 20250829-regulator-remove-dynamic-f1a6b8c0c1b0
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

This small series comes after some extensive discussion on a few minor
changes that can improve the current Rust regulator API.

Patch 1 removes Regulator<Dynamic>, as we have now established that
there is no usecase that can't use the safer Regulator<Enabled> and
Regulator<Disabled> APIs instead.

Patch 2 makes "devm_regulator_enable_get" and
"devm_regulator_enable_get_optional" available in Rust. This comes after
realizing that a lot of drivers simply care about whether regulators are
enabled for as long as the device is bound.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
Daniel Almeida (2):
      rust: regulator: remove Regulator<Dynamic>
      rust: regulator: add devm_regulator_get_enable API

 rust/helpers/regulator.c |  10 ++++
 rust/kernel/regulator.rs | 130 +++++++++++++++--------------------------------
 2 files changed, 52 insertions(+), 88 deletions(-)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250829-regulator-remove-dynamic-f1a6b8c0c1b0

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


