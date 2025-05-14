Return-Path: <linux-kernel+bounces-648276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C50B5AB748C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 20:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D84B1B61BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DA1289375;
	Wed, 14 May 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8NkvsKP"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C652882D1
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248125; cv=none; b=Xfn9qhIwvjzdPIb2XMA/z4s2L/aaPzL88SeIf4F1YkXmeZPYelLMfyZlGgTSV58ywropYzXJIFZMhMqun3Yv2vRUDYacyh8s7CcdIDNgm8y2f1EPeqn92bX8589LoC3dUIyWwuik4Zy4zIwdMekLELosLACl1R6WsnghoPWBhqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248125; c=relaxed/simple;
	bh=8WPS6fJFn9ZOxrssZfprQKVrhRW5a0xtdjp+RK/angE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nOT4qTtSzfGchsCMlCEWL8IaoxsPc9R2kClfAvxrCS96Sj9dxzwm2dC1X2P9WkEQnaybQxNa5aN53EiEhGYqJk3NnaGPbER5dnOxbj/jKrO6N5kq7ljV7dV9TNoHmknZEbHVhqOYp47ImUOiat9AeeuRkTX7Y0geaoH3la0b08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8NkvsKP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso30401a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747248123; x=1747852923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYJuHf6JfZCBn/xacOL2tI46jqMW4+1r9XjhA6jdQBY=;
        b=p8NkvsKPnNZ+zrvsTHEQjWzLb7E6Mb53DL0RSpRW1F0PrZPxzKFPKssadzM+phgSff
         I/tpjw3zfzsIcXCB7DYeWvJ0y4rlPMZC3a+3v+0S5idn4r+YTo/w5w9rcCEvFlanBN/m
         GT/hyb7gpk/WM5Bc41F/XzqVMVLqtGijFzeDWokwbhMsqBEc9CepwWJkUk2zztEKMYn5
         B55/G0ClyEvabZaNtJCXr9u2jDp9Xlnb9al53MaiJtSQx/kijKgz7B/TSacbPV5++FAY
         MF6beYoWQg2FNYQx6QVN39v6MztgFbjpEXX8PDz6iMmXTT7aoBQpKT5uaZqRau87Wm7F
         yv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747248123; x=1747852923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYJuHf6JfZCBn/xacOL2tI46jqMW4+1r9XjhA6jdQBY=;
        b=uw+hit6gvFdo52bkSuebGF6ujtfKFFUHHdvfpmQyjmd5tHrGdeVcpY7v/Fut94qcRO
         6dM5tRqK3MfMZCzwGBjZnnSbl7wj20jskZUuPejnJ/6Qs3NrQ+cAfuLNHw2o7ufmd0ND
         qFksKj8a5e3GR3LA4kNi0P41AdS4gqnhbYU94jxQ5FSLKWW8AdqxS1GtDRjsyvCf/GY0
         wkUUzS4yRAIh+QBXhwX5u6UlF2lI30ibXT/1Z9nGMo/ts8Hk/hLwTaxbySDpZDNIpQTi
         oy7Za0CRAE/ZFjvu/4JOdpLdeELbJ+DIutSfN9j8qPa1yFS3CwzLe0L/dnhTh+5SCDNy
         Zdsg==
X-Gm-Message-State: AOJu0YylS6hk+4Jdc/pzMrXmj7d2v7putCKx6ODDL4aDlUsnoB3m5LE0
	9xm3A8SApQfSBTWMu+HUqhQ633PSsc9E22HOMKqOX1S26iMYmOy/zX93wdVSbI1Na7te3JO2NsK
	l4KorZ+vMm29tFjJBLmsyPg==
X-Google-Smtp-Source: AGHT+IHaW0tGNG2An47wn7ypYPKbD5kAKXhci3mLdyKHvLgmgeV/RB/EAKA0ZnHx69e5p2D6/yHVAiXZ18yI4rGUsg==
X-Received: from pfks12.prod.google.com ([2002:a05:6a00:194c:b0:740:6f6:7346])
 (user=dionnaglaze job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d88:b0:1f5:5ca4:2744 with SMTP id adf61e73a8af0-215ff0d4647mr5637627637.17.1747248122860;
 Wed, 14 May 2025 11:42:02 -0700 (PDT)
Date: Wed, 14 May 2025 18:41:36 +0000
In-Reply-To: <20250514184136.238446-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250514184136.238446-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250514184136.238446-4-dionnaglaze@google.com>
Subject: [PATCH v4 2/2] The ccp driver can be overloaded even with guest
 request rate limits. The return value of -EBUSY means that there is no
 firmware error to report back to user space, so the guest VM would see this
 as exitinfo2 = 0. The false success can trick the guest to update its message
 sequence number when it shouldn't have.
From: Dionna Glaze <dionnaglaze@google.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <jroedel@suse.de>, Peter Gonda <pgonda@google.com>, 
	Borislav Petkov <bp@alien8.de>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead, when ccp returns -EBUSY, that is reported to userspace as the
throttling return value.

Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Sean Christopherson <seanjc@google.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/kvm/svm/sev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index ddbfdce9dc18..5901a7f59f88 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4065,6 +4065,11 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
 	 * the PSP is dead and commands are timing out.
 	 */
 	ret = sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &data, &fw_err);
+	if (ret == -EBUSY) {
+		svm_vmgexit_no_action(svm, SNP_GUEST_ERR(SNP_GUEST_VMM_ERR_BUSY, fw_err));
+		ret = 1;
+		goto out_unlock;
+	}
 	if (ret && !fw_err)
 		goto out_unlock;
 
-- 
2.49.0.1045.g170613ef41-goog


