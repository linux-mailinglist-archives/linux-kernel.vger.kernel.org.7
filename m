Return-Path: <linux-kernel+bounces-691277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40C5ADE286
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 06:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20A617C7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 04:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202FB21D5A2;
	Wed, 18 Jun 2025 04:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wXVWoh01"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499D21E094
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 04:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750220690; cv=none; b=dcxhqB3ty8XkMBzOjiTG3h3Xy5GVuh+uVQsgNkwXNCYGIp8nXSs7/Rx+DLwKXacG0HGsIqemAaRk6si0DJlm94z9w3Gd/yazYizZURlFc6iHCWuHI/01GQlNo/6pgNsYmBVZ869er4fGLIltcNybNl8eOSt/qLZ8iWRA1+5sk4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750220690; c=relaxed/simple;
	bh=0cy61o7VXZiqX2efmaNB3wv8cOwqSs6G7BooJP5WYek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ntyUN/Dfg91JRmI+WmwWXqIkcDPqAj0MesjncixSlKeZKgNFJGfJt7CizLrbPDd1l0EWJkRf9L1ITR2foo0+rGCY+ONDvi2fv9e2v7QdcQxQ7edTYkrqKtNHUM06gowC9mDqi8hOeimeuuHLzDGpuHidvP1ejPTnsVHXCODIzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wXVWoh01; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747dd44048cso5315729b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 21:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750220688; x=1750825488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=urfbfbke44pGtnk/FCqGVDeVvBhaC6syv0bCNmnixkg=;
        b=wXVWoh01om4NO2cV4iNiTb7pXfv2E/LFLcdXfVPTVn8OXmPLyoJlINQaiDvX/7UbRQ
         NpYTYiQ3fF+QGYDsMN7EsbH9KpBQMmYabYG+wnNr0BCDkK3Yd41SC/vUndBiaob3hCp8
         mLEYaxO9/U+eJ4sQMYftzvZMDat3f1gCHJh3O3NnXrc7sD9J6nPt8/0FnEMmvug542Ff
         NgVblA3MXuXSLpUNLsEZ7HJTRk6JsE6ZifpkS+KuydtPtcvZLN0Jfax/f2/sRSe+ge3x
         bY7G2tIyJlg12NK1cdwFzrAe9JfTL+bnIsQWqW/oOieBoN7x3QU0dN+iu9U3M1msUjA+
         U7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750220688; x=1750825488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urfbfbke44pGtnk/FCqGVDeVvBhaC6syv0bCNmnixkg=;
        b=LBHCBlxOTFT1+8PLjsAAdVlF0Fp8Yt61qjSzZNcglj/EYb+qWXs36cbLuepO/Ov2pB
         YxqoF/FfP0Hm4SnAFLyrpNnciG8tF1Ds+8gDqtRJbT61gGrc+xWCAEWCcYeEKX4hjtMQ
         ThVYrDHksrzXwRM+Vr7Cn5ZzuzaHAWhlwF032OCRBb3FKMd7LgI/VUiKIqv775P1AfMg
         uEPFqAqV7DtEwlbyJn7PO5dQP+++ITYmzEpLvNi+7dmYYQJAWaxCaGULttcTHpDqwK5v
         MT/qRn+v+ZYh94DCzk/RFd3xONYvgHQpoqb/1w4qQwMdXs1hzScxWPevD0muGithCNLK
         qZbg==
X-Forwarded-Encrypted: i=1; AJvYcCV8rX0/o6KlIR/CKw1pUXX1Tmn+8jgD4yYilv8CIJ4hfpp4p1r2WYITZ09YxHUFYgNz2OpqrTcRpDEP2To=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIhw0FlNM8EBv7h1D/skf1Uc35A3ms/CYgFOBzq6KQD7AkBixF
	PYdXa10YCdEsXQTgGeyKdKG7H98ZJN3dLski/KExtUf0Vi+DJKaOChimg+UXHhvRm+531NGWBQj
	gVpTOmFcMsbQmoLUpvOAa5g==
X-Google-Smtp-Source: AGHT+IFPdIrbDlRQ72BheICD/uy5q1y4Z/C5VNYBV8bJ51Pda+epcBJA7XWiJKZlOD5QXWSznMTbbr9aSRYhmJ8a
X-Received: from pfbde14.prod.google.com ([2002:a05:6a00:468e:b0:748:dd5c:e882])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:21c1:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-7489cf5c8c2mr21855970b3a.1.1750220688256;
 Tue, 17 Jun 2025 21:24:48 -0700 (PDT)
Date: Wed, 18 Jun 2025 04:24:23 +0000
In-Reply-To: <20250618042424.330664-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618042424.330664-1-jthoughton@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250618042424.330664-15-jthoughton@google.com>
Subject: [PATCH v3 14/15] KVM: Documentation: Fix section number for KVM_CAP_ARM_WRITABLE_IMP_ID_REGS
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	James Houghton <jthoughton@google.com>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Anish Moorthy <amoorthy@google.com>, Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>, 
	David Matlack <dmatlack@google.com>, wei.w.wang@intel.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	"Xin Li (Intel)" <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

From: "Xin Li (Intel)" <xin@zytor.com>

The previous section is 7.41, thus this should be 7.42.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 Documentation/virt/kvm/api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 1bd2d42e6424c..ff0aa9eb91efe 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8528,7 +8528,7 @@ ENOSYS for the others.
 When enabled, KVM will exit to userspace with KVM_EXIT_SYSTEM_EVENT of
 type KVM_SYSTEM_EVENT_SUSPEND to process the guest suspend request.
 
-7.37 KVM_CAP_ARM_WRITABLE_IMP_ID_REGS
+7.42 KVM_CAP_ARM_WRITABLE_IMP_ID_REGS
 -------------------------------------
 
 :Architectures: arm64
-- 
2.50.0.rc2.692.g299adb8693-goog


