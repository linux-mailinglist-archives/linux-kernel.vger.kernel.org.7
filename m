Return-Path: <linux-kernel+bounces-847524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EC8BCB191
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776A43A830A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480D02868BA;
	Thu,  9 Oct 2025 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYQ+c9tR"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C434283FF4
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049170; cv=none; b=HpolI0e+nfuMcilnJ5DF6e0kzdNl2OUXzIdh8vhjfugBPz5rlb5EMPtn8lEV9a5dRW5bxHydjNEaKOBfX6zZppgumriUoJdMO8Ednk7mpFacBLc7/wX42xp2Vcz3K1v32Uujg9fb1DeYdcv6XOHayh1PkRR3QFytAolsGRHuuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049170; c=relaxed/simple;
	bh=NU8MMIkrzdP2RFlhl7HtsD71stc8eg3Za5EuqmEUEQs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tBpAtxZzr9IBpMzabFHQ8p/A71s5IKpDUyCchSN7gUQxC5mRlBz2NL4OmaTZe37/j+s2jFyROAUTrLgjMjtfzw1SgjxevqlPd8Zt3wxbS+HcUWzAOBVFh7LKrF4cWPvAXr3aaNK5mdYn7kbSwYoi4ZPtMV+/cMoWqv2Ec8r2yF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYQ+c9tR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befb83so3772067a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760049169; x=1760653969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t/z9HFIaNaxldshHk70QL4ZXk5pmp482oiljiBf3lBM=;
        b=nYQ+c9tRBy8geoFsAa2QDJj7PjaxWFWPVd6sh9/Vl7dfbovxaMCYHCu0J/NThQtWt6
         SqBjCA78X877p63vMvnSK9L01ou0T2XCTwBwof1gi8W4z2t8YD1kC5/Q8l8CnD3NvXiT
         Hi178dtLTBk9Wzrcxlu5tEE6GNbVU8830czb+dQvSXT45Io9cqQvfn+hPh06UCVfeDR6
         3e/qzPlr+J6bEHtaVndausZxToLC5k1LtgpTRQsYW2r340q8mfVCabOzlobD2KbwL8ku
         38NM/JTwFKkWYQ0rh5LXjMA7QHoj4PhqRk+rQOpkOAuYwNvfnz1Q3Ao5oH/AAy0hSLec
         f5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049169; x=1760653969;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/z9HFIaNaxldshHk70QL4ZXk5pmp482oiljiBf3lBM=;
        b=AU5UzxsDyr6QnwxO06V+GlIds8MJ0IBzXUzhs0kRhq3jMpZ003QIuApTLhvbw4/DLp
         7Syiv3tNvDFeTn5+7cQmEaj0OXtEn4v896lp9/3OLTaoJt/eIgA6wugXX5yZGBC/JOMb
         NeffxRrA+pWh3Cwb64rnzZaMEhYExLhNMEbd1o+/nw2ed9VUrPU0KSZCmWbkQjqacYZG
         L6ujeMpOo95VoEVTVha7eq+C5imZKy10CyW/rfDUkKWWP44rgVe0/IiaLF7kYO51H52B
         Hf5/yjSZfDzAHCN7x+51bE9CgtPfEnpu37+K8ec9cBZRmAIcHw21YC2YbFSYfuGFYemi
         Ic+w==
X-Forwarded-Encrypted: i=1; AJvYcCUY0WpnfHqL+9W6escYebuyofE7VMg62Jody/tcCS1+jKIaxLgrIEoqAOv8+x4jEYPW2SiwQt9L6qMVYs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEI9Ab/36lmrSEtYdMMxHRYPAS2ye2byQDtqBNCgO7CjM0lcR8
	2QihGLi6mH3boC3s6xLtDzRK963SwEgapFhB2KggxIKudm3qnq/4Wl/N0YO0gm7BBbtNoW5PZuw
	07W64R2hTqzNENg==
X-Google-Smtp-Source: AGHT+IEwSFeBYteMcJZCnm1QgWZBLXFpxxLGHcnQyhjOAgyKeXkUhr/10aZl9D1dDA1qusaxBOUG/w/uYRV9ZQ==
X-Received: from pjbgq22.prod.google.com ([2002:a17:90b:1056:b0:33b:51fe:1a81])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a8e:b0:32b:dfdb:b27f with SMTP id 98e67ed59e1d1-33b5138e27emr12697894a91.17.1760049168082;
 Thu, 09 Oct 2025 15:32:48 -0700 (PDT)
Date: Thu,  9 Oct 2025 15:31:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251009223153.3344555-1-jmattson@google.com>
Subject: [PATCH v2 0/2] KVM: SVM: GIF and EFER.SVME are independent
From: Jim Mattson <jmattson@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Clearing EFER.SVME is not architected to set GIF, so GIF may be clear
even when EFER.SVME is clear.

This is covered in the discussion at
https://lore.kernel.org/all/5b8787b8-16e9-13dc-7fca-0dc441d673f9@citrix.com/.

v2:
  - Allow KVM_SET_NESTED_STATE to clear GIF when SVME==0

v1: https://lore.kernel.org/kvm/20251007224405.1914008-1-jmattson@google.com/

Jim Mattson (2):
  KVM: SVM: Allow KVM_SET_NESTED_STATE to clear GIF when SVME==0
  KVM: SVM: Don't set GIF when clearing EFER.SVME

 arch/x86/kvm/svm/nested.c | 4 ++--
 arch/x86/kvm/svm/svm.c    | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.51.0.740.g6adb054d12-goog


