Return-Path: <linux-kernel+bounces-844678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E81DBC27A2
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7555C19A0881
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11729223DF6;
	Tue,  7 Oct 2025 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xd3cM1sU"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24B221F24
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864359; cv=none; b=tmakBpazicJljIwGGI2kq8GXkmVAlQGcbMdpqyXqresUnmdmKrmP6inxftc/Z+gJM75G3rpPephS5J9zp0f3yVTRyx8CUqlM+uGRR7cNpbFK4QzwPpGUfrI/WTCseNjjMA7N2+AkBVIH04a9ZEuOFZwWb2Z00Jah1/kAbuAuN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864359; c=relaxed/simple;
	bh=1zq+wnX1vqfhxHgRG9451gSG2RiJStNjkn4b+44kVWs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AH+w0IHJpWricy1HVHRD/ULlC3iy0n/NOucDLgcS4RKEv6Zp8VPRgVHN0WlfrbPacDM5oq6IEjwrZdJx6BkNjs41JbM0tELHdCcQ0l1KoH7obfynkZKqJhmYxIVoFISOfcS32Ggh5ZrQtbPB2qnUBW3N/zMYvBGHHPtDkrmJuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xd3cM1sU; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e25f5ed85so41988215e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759864356; x=1760469156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xvaIFYn8xxn1Zh95yE3a4kb+EhT+TJRLQn+JPUMtZMI=;
        b=Xd3cM1sUDRdMe/hcpWwKJOjdwiam0WZf53hvhu1twpYFP2Es7JPhNB6CJ/gbrymL1O
         X4I+WecHOmNz37dKHwYlyzi52nXJpUviymGuzkhUQ12WPrv6hczXnEbjFeHzaG7jTJbT
         5tPLd41WJC4rYdxgMiPet/lhVXDClNj2fezr8GzuUx1HKyH7z1XjQ0LDOV59z6TpyFW2
         xcQKbGFmAk2yoG4c20eEYORNXxWpZ1E1xGDxNyUbOyANGP/HA98JnN/39lMtR7ZvD7+C
         RkxI8Jl2yAW4RBm3NCO5QiVxwPN/I334RD7nQFlCOEg7ASlbg75ffJRPfLnMPFuzt5G0
         MXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759864356; x=1760469156;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvaIFYn8xxn1Zh95yE3a4kb+EhT+TJRLQn+JPUMtZMI=;
        b=k0pXcSTjevuugJSLAOko+vVRLgw5/ZPm33iuvo6Cd6tl0lZbWIHE8VroBfsn4YiFYU
         RGfHgKzROXSFlKjfTl0BQBi6MSubUoh7DooffBhUhSKsYqlrYb8Hutx1yqNeZZ/1ELzR
         7zJ9FZtRcXXOt/e+s1ZhAo5OghOckIMLf1TjHQJs4zj2dIQKNXrLPxysdEJhQNlDxobB
         3lObrJGle+5vGCSkrR75/gm9DlSapO3/CDIBDUD4VmM4zOww9cYvqv7MYC8MRSe+nCmO
         F3AvyhzJ62MZRy7HuvN+/uHQfs7iMmkFruVOOlslE1WOZ6RUrkbQP5dsy2X9mvruNZZV
         XXcw==
X-Forwarded-Encrypted: i=1; AJvYcCXt58NDrq6W3GQwRB81xkeqf1sgBpL5Ev427fsNOfdO+p43/FHhWDoNM6Bz5/Nqnf9oPY+KGKVCauTN8Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFiuXtvRtvxsrjCnlFNpzu8Wo/a35fJAbSQZ+4JoVsSbbzyvWI
	g3PZfBYRgbYm+jdUsF/VgvkhravvuKtu5ry+OV3hGwcOjtq3nYQpRZ872WvF7b+lJFRQIFPC9iF
	FGZrs95L/nr6jhg==
X-Google-Smtp-Source: AGHT+IF8cPzfTUCADjWMgjnDGXv9bUSJvQjzkSR8TvbNkHcOTb21Htn49hpM3qx+nFkCimdVq0HJmb49CeMBYA==
X-Received: from wmcm4.prod.google.com ([2002:a7b:ce04:0:b0:45d:cfa4:ce19])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e8d:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-46fa9aa1d13mr5841565e9.12.1759864356219;
 Tue, 07 Oct 2025 12:12:36 -0700 (PDT)
Date: Tue, 07 Oct 2025 19:12:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB5m5WgC/x3MwQqDMAwA0F+RnA00Ou3Yr8gO2mUapCpJJ4L47
 5Yd3+WdYKzCBq/iBOVdTNYlg8oCwtQvI6N8sqFyVUPOeRweOO8RY/yhJWWzxJaQNl0DckuND1T 7p+8hD5vyV47/3r2v6wbvcihFbQAAAA==
X-Change-Id: 20251007-b4-kvm-mmu-stresstest-1proc-e6157c13787a
X-Mailer: b4 0.14.2
Message-ID: <20251007-b4-kvm-mmu-stresstest-1proc-v1-1-8c95aa0e30b6@google.com>
Subject: [PATCH] KVM: selftests: Don't fall over when only one CPU
From: Brendan Jackman <jackmanb@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Running this test on a system with only one CPU is not a recipe for
success. However, there's no clear-cut reason why it absolutely
shouldn't work, so the test shouldn't completely reject such a platform.

At present, the *3/4 calculation will return zero on these platforms and
the test fails. So, instead just skip that calculation.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 6a437d2be9fa444b34c2a73308a9d1c7ff3cc4f5..b5bd6fbad32a9ad5247a52ecf811b29293763e2e 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -263,8 +263,10 @@ static void calc_default_nr_vcpus(void)
 	TEST_ASSERT(!r, "sched_getaffinity failed, errno = %d (%s)",
 		    errno, strerror(errno));
 
-	nr_vcpus = CPU_COUNT(&possible_mask) * 3/4;
+	nr_vcpus = CPU_COUNT(&possible_mask);
 	TEST_ASSERT(nr_vcpus > 0, "Uh, no CPUs?");
+	if (nr_vcpus >= 2)
+		nr_vcpus = nr_vcpus * 3/4;
 }
 
 int main(int argc, char *argv[])

---
base-commit: 6b36119b94d0b2bb8cea9d512017efafd461d6ac
change-id: 20251007-b4-kvm-mmu-stresstest-1proc-e6157c13787a

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


