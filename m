Return-Path: <linux-kernel+bounces-863030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED77BF6D31
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6F93B227C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1B337B8A;
	Tue, 21 Oct 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="laU99bV7"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB872512DE
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053916; cv=none; b=mqpmjGpazn3Jdgabwsz/gO4gbfTSQRYRWC0P9zblpUpJD7Jl8PYY+J/5SftE6u3kzmHODMsvmDPA+NsgbmZPOcB25Cg3zIuGAmxSotY0Y372FBIvPyVj40GZx53w27TkmeyMUipaiJZKQwcZ34vPQ3hvYrnErprUAtgEicNHBKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053916; c=relaxed/simple;
	bh=z+qE3mqR5qH0hG46rSsVRK63icU+VehQg+WrkGQUKEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TscUeNPKOdCmwCSw2tEOEhH1loArzs6VtFfDkIR4fdxl0ArTLQGcxAnlyIWXAPMu+RALjImK4D4TsTd/xOY/ni0GYJLQaiRyF/30TaFe/aWqiHHUsyOWVO6+ITgVRn4bqBCvp+7X0LiRCT72rgImPdLsYapTm/ADiqTVlDNwQwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=laU99bV7; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4270a273b6eso3081025f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761053913; x=1761658713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGRey53sSgQZ/gBzTiyYAHyyXx3ws+H0lBwdiUb5eBc=;
        b=laU99bV77Yb4s6zrFPpitLVC/M+P4emGJRZzo885CZoIrtFsE8ryS31+4WXYGmgcKd
         ig+IHtzdjCvHQvkLUfNzF1HwZOESD+nYCp2TJDhwAoz0g1bfX8fAEPJZCHRC3j66ZqH1
         DurtRj/nCYjquVh092LYhs+ASBk83PeKsB2WNWBoNaHX3FCpf7XlXylveVXBGkNdRZCt
         lOlHwf/v8AlCPyKF4E82gWAn9wOYohIB1YvbpmGGgb60+eLKTna1Tlc5x4U/VTj1XBpj
         VrtHf65lcERtx9SezuHapD6hhYKP7S8rYn3BNmUW84ht1rnt/f2yZ2oZbfrwuWR7Ltue
         FWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053913; x=1761658713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGRey53sSgQZ/gBzTiyYAHyyXx3ws+H0lBwdiUb5eBc=;
        b=fYnAhpCi5vePnx9KqhiuBIbbPn5HJDS+4T2OX3vl+7en2loh+dPXG1fwOLZACZKBu2
         XuinKjnvlNNDFLgDbkQ/I3O7SA42JENMyfwSII4eexNLVWMnmDclzuBtP/f+vtdnjesS
         ew3J9aSCgfuT3WIA4I3NQXdfST8nMaVQa7Agtuh5NknsFTeC5VtE+tn0cX8GNiafsWdG
         It/R9iPsSxe3ma7jXxcFQxiNkjE+lv00ukX1+BTQYidINAigqV+RG9cPtcAMBmEtLhn+
         deXZYVjsZHGswtEnvpG2WgzuHSFBYXgp2DG14FqfQxrwRSumhD8wPI55qSBjZo2F+GPZ
         uOsA==
X-Forwarded-Encrypted: i=1; AJvYcCXhOyOwK5wJ70Ycr8Fo+mYUB5T+mUQLdSNbsfPwRI5cIDY9iTR4L/3VNp9J0m5/WnJyJanLFOC0DqpLyj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7YLq5Lv7cuokgIBh9s09cYrINiRfmuHVw7CVZtobm4ST3XoY
	TvKAqzXaiTvog+5ZZ1WY+ztXgu6JveVjF1eobW2sY6NLz+oCg5MqFQLMUo83Vsb02P0kj7onwD9
	z0B/3bz75SFVKVg==
X-Google-Smtp-Source: AGHT+IGvYN+oeWDuKrzhX9dTAvv1Ui1CTP/nYtpayau6mHX1JvveEYbt5nmnaGDDpYB6fO6OhbjffwACgPNrGw==
X-Received: from wmwq8.prod.google.com ([2002:a05:600d:8348:b0:46d:6939:1b46])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3492:b0:46e:3193:fecb with SMTP id 5b1f17b1804b1-471179193c3mr111611295e9.27.1761053912715;
 Tue, 21 Oct 2025 06:38:32 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:38:32 +0000
In-Reply-To: <20251016200417.97003-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016200417.97003-1-seanjc@google.com> <20251016200417.97003-3-seanjc@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDO1IEM7301W.2R6AISX39D3UW@google.com>
Subject: Re: [PATCH v3 2/4] KVM: VMX: Bundle all L1 data cache flush
 mitigation code together
From: Brendan Jackman <jackmanb@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu Oct 16, 2025 at 8:04 PM UTC, Sean Christopherson wrote:
> Move vmx_l1d_flush(), vmx_cleanup_l1d_flush(), and the vmentry_l1d_flush
> param code up in vmx.c so that all of the L1 data cache flushing code is
> bundled together.  This will allow conditioning the mitigation code on
> CONFIG_CPU_MITIGATIONS=y with minimal #ifdefs.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Brendan Jackman <jackmanb@google.com>

(Git says no changed lines)

