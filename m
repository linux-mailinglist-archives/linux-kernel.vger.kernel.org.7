Return-Path: <linux-kernel+bounces-794592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5C8B3E39A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0960B4423D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824D327789;
	Mon,  1 Sep 2025 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSJfNhCs"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F8A2749D1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730754; cv=none; b=DuC3QfvhKvR5pjvUt6SHH7U4yxDc4cVv8eLf5SxZ0/Zv+aPcozq+BnxkQqumDzZaSg05WjfifA+s1hjlkdHeyod908rUquw2+aGkRD2ntoaQ6/5UafdujC44LxirbebGWOQQ3LwSPFMdggCd431ma6slvHIClNjBsoAaYGD0sRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730754; c=relaxed/simple;
	bh=kKPxwMDQ12/QlFsJHDAQpUGCRuy72hF3jfEmjy7TKnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fK5NgFHdiCdZq3zvKrZg4LheOvmkKPv4WgOI+0On4S4Be6NQ4r0opO9keLPaUSjIoDZ2bthTsV6oEY7m95joO5VdKpC6APFatmNq8vndUORYeM1iuQcS8EgdhH7o62/flF+vWxHPoMb/GwDliGpeXlyYCxr7ZZ184rHGV2d1iZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSJfNhCs; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b475b63ab66so561050a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756730752; x=1757335552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LJ4r9mMq8e3mdNbo2g6rD5aD5gZi5B+2aiqw18aFtk=;
        b=MSJfNhCsg6l7+jA+lUrhyGBeNv3JjmGFsJK96QsReaEt0kgenTbJ6NE0utV2K/kMW4
         s1T/DZmz+EtpvcIHKdTyJCoNpYtQhXBujgGgI76LDboA+y66P8diKBtyBrwsr6ESWMrq
         KV+PgcLQ7Kmtc7L7DW8rZPfeTnExXY1pydiF0GdzI0lsLJ+dQn47vDYA4wQNT11WF5CX
         Jy6/m1tcVjsgQuod3irsj2BxK5u3CzdwpmwxjdGMDurI2mWixibCgtVQPYjRJqsXosSE
         LbL/a3S6+8fJ32+t65Qw3+b9GR9eeJGSOzjQ5vtJw3hlPNwSxWFo9tbKDE2FANRr4wgu
         bKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730752; x=1757335552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LJ4r9mMq8e3mdNbo2g6rD5aD5gZi5B+2aiqw18aFtk=;
        b=Na+oV4LpxNW9lqLQ4ne1+v0QGptQ52LP3hW8ZAKMxXdZjIv7KjFc0dUnO2+xpzoRCo
         evUNt3pZH5LQ8WH3XbvUeeQ+YSRZ/CRG8KiUUXU6lOlr9n0mbXvY/C6pbP3jdQnZ4t6V
         qrPK2QQ9UdbEyl8V6yqk+iKNDXmApt2O9VJOWuRzzkk1otM+kqqLI0URVF0THmxex648
         cJc+PBR6Ne/uKVdO0yDCPdEjtUy/ILFF0mC0qMza30bnX/YnL2TIveQTUYJ3zhfnOTAQ
         zynUEJvMC9AAGHoSCrtPLwTPFpCXn5Y2HGvK29OUvXkY9vfKC3GmRG31YB/MRztjSoj8
         jFMw==
X-Forwarded-Encrypted: i=1; AJvYcCUtpCb6WJrHx90cKheH3KBBZ2Qezy1Au+d7AaVm/Kx8c/EOsT7IDbeoI9xZ7f6UJND5QavscSvwOLVwSQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0bMUzyjjMwrEMoIAFNgdiNB8J4DEIb+5VfIUwb1xCj1PELMIL
	Dg/CyW4/GFK4FlYRezi42k0y8rUx/Gm+9jszT+Q1N0H5Gii3hF5S3M3q
X-Gm-Gg: ASbGncsSUMeAgPy2BEBcpKxKs6U1sc4QzA5sD64mNabUsYrR7i5OhKYMfjO68VtB1un
	mFWP0JsfvBjG45kKkUDsCDt1dVBzFXWASZunDO340M28IJj5JZcQRGfJFww9YAXXV90iPLhTZ1E
	bv2LzWkFLncwCSl4Yq58vskDBE+EV4v+/3FJNFAHuAnIKhaG6wG3qXGIhAJeLM3PR4b1TO83Mxv
	cdjdAm8O5hnJo+hbPODk4KheRV5WwQJUmjjxyVtKgarnKAk7hXNtMNWkPFIfJVaNhhw2sEo+BN4
	GoWnI5URynURGADrCHztorsMLbyO9S5KmDi8YqgFVzIhfUaLy3KJf3tsKNUTOO5NyLl1ZJzUSYK
	IA3uXUBm/PC4JOg8ikgaoEg==
X-Google-Smtp-Source: AGHT+IHN71zGlOOMRyH+O5wcaJBAY1QklGt6JPB0plU5qIlkRtUqi8nYhrHaVrv2vP+4Uv8jYf4bYQ==
X-Received: by 2002:a05:6a00:928d:b0:771:eec7:a71f with SMTP id d2e1a72fcca58-77232874e8cmr5779479b3a.4.1756730752213;
        Mon, 01 Sep 2025 05:45:52 -0700 (PDT)
Received: from localhost ([114.70.121.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723d79fcfesm7553805b3a.16.2025.09.01.05.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:45:51 -0700 (PDT)
From: Gyujeong Jin <wlsrbwjd7232@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	wlsrbwjd7232@gmail.com,
	gyutrange <wlsrbwjd643@naver.com>
Subject: [PATCH] KVM: arm64: nested: Fix VA sign extension in VNCR/TLBI paths
Date: Mon,  1 Sep 2025 21:45:20 +0900
Message-ID: <20250901124520.54259-1-wlsrbwjd7232@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gyutrange <wlsrbwjd643@naver.com>

Signed-off-by: gyutrange <wlsrbwjd643@naver.com>
---
 arch/arm64/kvm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 77db81bae86f..eaa6dd9da086 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1169,7 +1169,7 @@ int kvm_vcpu_allocate_vncr_tlb(struct kvm_vcpu *vcpu)
 
 static u64 read_vncr_el2(struct kvm_vcpu *vcpu)
 {
-	return (u64)sign_extend64(__vcpu_sys_reg(vcpu, VNCR_EL2), 48);
+	return (u64)sign_extend64(__vcpu_sys_reg(vcpu, VNCR_EL2), 47);
 }
 
 static int kvm_translate_vncr(struct kvm_vcpu *vcpu)
-- 
2.43.0


