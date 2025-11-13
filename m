Return-Path: <linux-kernel+bounces-899084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0786C56BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7270B345C07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6348C2D949C;
	Thu, 13 Nov 2025 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IBIIoZlj"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188773AC3B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028078; cv=none; b=CVji2n6aTydZQjFSNu0LbjSiTgorf8RTeWQC01NpeV0Hd/Oi+/xSbeJMuYj2qoA8whWL6rhIkHRw6YBY00aiSruczSl4XN1Ua3/9z2NHr3E/5MjpfOYhrZqd0VidUgk17sQS0VGEvw3efFlW0T+k8d5TMjq4RV5YnLRuEpASzqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028078; c=relaxed/simple;
	bh=qSmieh5GIJz7WdTpE0VvnyZxLaX0gfMgJ/TGou3NzUg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fwiLsGZ6tlVIwgMae1HnmLSuaR1BIhWyIo51khP+HVKW5Qm1IqM+z9iEMGqihNgrkpCpPmt47KLgzYfpSomwoLdKmMaipXtBo1OlAwFMizOthAiZI0JpJQ8n/D95TR6BbMQI4irnev7ECw7Y83s/gyE66batBf8wpA8KIV6lPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IBIIoZlj; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6430e4b5f04so740415a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763028075; x=1763632875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XRxy9F4cGMdC2FCd5EtOEJinUK82Lj0oCA5mRVZonf0=;
        b=IBIIoZljdrWwSdD4Rj7vgZDpjmt3oC+1RgdJXajPcne2N2MElnfnhSTpuoHW70rS4l
         bjTc8BJEnVz0DPOnUmP0ZQiZjzZ52fDea0TkYjsCT6zZfzvuwYbhLIA9hW6CNV7qg23b
         Coa/Teby469u3g6rbF6XSYJbG6zmOgk20u7+gnQy3Ze+zhP251HCQ8UpyThE+NnQs8Ay
         8G81Yd0U7vDhpRHoDluWB1orDtq4WqnkIPV+1sXISkWazvgDcsq3CcD5s1yUWKs5JyWY
         AfF89F3v3UwGo2Od5F3jp84OObh2MxtuIxAamawIb7OY18sJxTJ1nVBfuvjXqj3uL7Gk
         RfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763028075; x=1763632875;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRxy9F4cGMdC2FCd5EtOEJinUK82Lj0oCA5mRVZonf0=;
        b=Nhs+iBjABKtwDdOP/vQ0uq5wDGIko+/Gr/UoHU0omfAgTUSGTsE6wVdOJZqiJi/LQB
         s6+thR5Youww5fZLYVuWtPL1jWlPLhb7Gxy2b1Y37ZlNp60h+KTKpgRg8DLYSpMw+qRJ
         OcnJwmvOCMUHuHFpXwW2LuEatn22grbnJkeYzWALg6rFvWgmutpfmsFQc/hBDkEd3ARl
         KBnqCY8SZjvRFlbHLJUPYgaeeOkH7a5RiJY8tVPWgj36/xqDWdndN29uZ8fhIW9Nkmya
         /HW0Qbo+4e95qIZJf15Kk8exZ2ukAbkOUQPO76sgaP0b77LeiHONEE6J/d4R0tTWcMH8
         nq8w==
X-Forwarded-Encrypted: i=1; AJvYcCVhTZ6sOUcoNMQHa2v/hBAWziMt/+b5DZIuO8sDuOXR4rp4nMtbkto8mvznsO3FJsd3P41NfzJATh3LfWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqFLdeO4ejIvkpoQa0YzwLhWqpIRlkMgcIdJzvcL/sCVXauqd1
	X4OD5zNrC+80skMxwM0gdsnQjPcwNva4zS7iUeHrrA0oavkDN+ik5AvCkHD+L9/UwKUMBWY/NX/
	YcxwroG4r/zVKlJ2qzQ==
X-Google-Smtp-Source: AGHT+IHurnZ+1XO9pp+jBp2iadJziNb9uxKqvxGfSkgTnNrRbxt/kJvqjohV5y+kf6f2aRH+huRgmfc1WiTh41c=
X-Received: from edy9.prod.google.com ([2002:a05:6402:5349:b0:643:2986:328f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:455c:b0:641:8f8d:e633 with SMTP id 4fb4d7f45d1cf-6431a55e40bmr4730762a12.28.1763028075473;
 Thu, 13 Nov 2025 02:01:15 -0800 (PST)
Date: Thu, 13 Nov 2025 10:01:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGGsFWkC/32OwQ6CMBBEf4Xs2Zou0mA8+R+GA5QtNCqFbYsaw
 r9b0bPHN8m8mQU8sSUPp2wBptl664YE+S4D3ddDR8K2iSGXuZIFotBMdSDxcHydIkUSrVQHVEd
 d1kUDqTYyGfvclJcqcW99cPzaFmb8pH9kMwoUpmwbKg2SVObcOdfdaK/dHar1q2eaYjoafhvr+ gYasD7UxgAAAA==
X-Change-Id: 20250411-create-workqueue-d053158c7a4b
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=qSmieh5GIJz7WdTpE0VvnyZxLaX0gfMgJ/TGou3NzUg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFaxltzYXR6OLqAsJiPw+l+A016Am0HMQTYQrW
 chzpC/nvwaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRWsZQAKCRAEWL7uWMY5
 RhT1EACosSHd9YdCjwP2SW94Ag8OUOb2q/5u4Z1yLlMOI2aqKQorDMDghZ5qDuhhxH74UXBcG5h
 1K/Ggp26/Q1ur9j4QWY+RJiIi3WWnqKvvAV9++OWLWfCquNRxbHEI4dgP6ckRrfjFukI85s6Bsb
 YPv+FC9Rw3rjAT9RIV16QCU7Bz42kuiXW5+7Hx0Q8xljr1T+vLctdBpX9YtOaie5Tb9caHhXOah
 +Vj9TExJfyM/9Bs5vww4d0VWSfTxV+n1vJIOexwGMw+pwfabvE0rAv+2OEQAqEQc5ND7GzW1VL+
 dXBg7/ZNyAEh5o9J8Ufwxk3RpsY+IKOYXrpRB2vVbS1toB8/Y0CbzKd/CI3i6fdR+1eT+DWlvor
 vr/k4aVb4TyJOWJ1z0LFrSZ2/atjcn01LyBMj/oEn/OOhZ1iqBuAt4LX8pcTWii9vRWRrVoYMBO
 murpZIQc4LwHh+XYhwS4up+Z+SRmgnko2xST9WNtvPgo5tR7Sn7kKsDsRwTja0d0I8qBzgFFCxt
 ZdEmAqYOOA1iTCwZv0LTc8uPKE3Kzm/JAb6EglLWAZO4OPVGzypE5aqfcPTyOB7lNKaFyOAy0XH
 3/t+rAnpSv2UEzfheVbFPsSZjqe7XPzw2Oiq1pLbgcR8NR5IxDRzBfPK7Y+OKkufi55re9h82kD +Z5q408wnlN+UvA==
X-Mailer: b4 0.14.2
Message-ID: <20251113-create-workqueue-v2-0-8b45277119bc@google.com>
Subject: [PATCH v2 0/2] Creation of workqueues in Rust
From: Alice Ryhl <aliceryhl@google.com>
To: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, John Hubbard <jhubbard@nvidia.com>, 
	Philipp Stanner <phasta@kernel.org>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

GPU drivers often need to create their own workqueues for various
reasons. Add the ability to do so.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Redo how flagging works.
- Restrict delayed work to not be usable on custom workqueues.
- Link to v1: https://lore.kernel.org/r/20250411-create-workqueue-v1-1-f7dbe7f1e05f@google.com

---
Alice Ryhl (2):
      rust: workqueue: restrict delayed work to global wqs
      rust: workqueue: add creation of workqueues

 rust/helpers/workqueue.c |   6 ++
 rust/kernel/workqueue.rs | 187 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 189 insertions(+), 4 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20250411-create-workqueue-d053158c7a4b

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


