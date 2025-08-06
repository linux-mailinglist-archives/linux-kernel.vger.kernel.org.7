Return-Path: <linux-kernel+bounces-758232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06746B1CCC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0162B3A9ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D7B2BEFE8;
	Wed,  6 Aug 2025 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CcqyyqZT"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD82BE7B7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510257; cv=none; b=YpwAsY60BxtvZIR1F5Gd7jYZaKfuvZsh+fJxrWMD9oXrNapYoSAEr1ZwtBeWdBxcdfOFT6ZioYnaKjvFbi+a3U/O4E8R4y1xV+4hCtCdSYi+CUNsqyxz6fT8tfHKnmcOXN3hPRyx449MhRmQCRzXi0bRRWkWKnMrVoLImsLOWu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510257; c=relaxed/simple;
	bh=tS0WmC5r+kmTtxkhhYKlXDU+egOc68kS1ctzXr8LOA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nFu5u8AAIzEg0tYQnaKQ1fDzS6bRImGsNldt+zIdFDI2S/PBE0FgdIY27LZGCcRsjc8ZiA4WpYo1FzDZ7sbcM1YcisCa+LDmv1i+x394aZVNPcz4dREuUsfQX4tI7lDwKFcunazZVLgzXaoYkB3YcnjNubF5JfxKNF9GHOYTpRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CcqyyqZT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c36951518so245340a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510254; x=1755115054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tP9GWyHDKyhyNham1AJeXmzoVBEhNFAEzN5Uklpk9I0=;
        b=CcqyyqZTQ9+tu9RFgIsmhK8g25sm1T5DiiFL+2GVwNSk1syEvZSf6LdcDIqXgOvI41
         gQNYjs1UElWpwcKrpQnRV0alfOEx8/MHN4ilTPUYO+bCnxFXUy6TORaL3IytBor011yJ
         SFPcNAoXHsE51QXzOkrfgJhinKbMsfCLFNJBEzup9ttMWtu2rVjcdDXUHw9IZfNOHCrn
         EEwrVOklD2vysXLvc6jZM2RUEd71y6yZsUEfBkk+xXpnhQm+++9FWk00CnLwhxk/qLLL
         pkWA/vG3zqUcofDwL1dD4nWTtxnZUMm2Eg8hJIFeXfLpURozsDlQj4h5tbpD6XmN+IhV
         YpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510254; x=1755115054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tP9GWyHDKyhyNham1AJeXmzoVBEhNFAEzN5Uklpk9I0=;
        b=YG0vXLF2s/4Jdhe1iiY9gwCeAQ2+xI2TQWurh2WuoetWeXHRolLmWT7t5dvi9ggH/H
         jzwf+ViuZ62i93aA+Z4j07PxmAgS26sdJmnKrd/i9Dvocha25e3m9A0V777dfrYMxkpS
         vXvn0CfcLqKdpiCyjcfJ8XSzNMcNYrxGR7/gk51yITDlV1dSQrQQX5CgiwOVHv80CHNf
         p4/6sg8tPWntaAWj3S5eqwXOPNOsjqWjp/HylV8LiYyT//eSoAkWOliI+p2zosSmbh2v
         Q1ZGPAmjbaxU+1BD1iSKrg6po6bqM+PkW/YzqjwyppR/pEXYkfzthc1Wx/u3A8mGQpZW
         oqFw==
X-Forwarded-Encrypted: i=1; AJvYcCWlsh/L3hNTs6J6znY9qbv6p9CBBBpVfV49IijiTP0Uye8FJYgHuLRqSD1ynk6W5MDwhkLlgUmPQAK3RIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh4W73rBYnmS0xbBXSUYtcN4KXK30iaXgayFIT5EFIGyBl4Jpj
	EKFJoF2+c4J9niGJxdTCaCMXoTePofYgfPVWPTcfel9AjN42JsuvpOwcB5f6BBdkifl/vlMCLpK
	iXdsZjQ==
X-Google-Smtp-Source: AGHT+IE0CEB3xtAs9hI54+H7B1IyMBLcepknW0FCY+2mxv/eXxKsKgLhnBmg0Z6EMAhWWlTkD97yQMZQQo8=
X-Received: from pgg21.prod.google.com ([2002:a05:6a02:4d95:b0:b42:3ec5:d919])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5493:b0:220:aea6:2154
 with SMTP id adf61e73a8af0-2403125bcacmr7040722637.17.1754510253905; Wed, 06
 Aug 2025 12:57:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:25 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-4-seanjc@google.com>
Subject: [PATCH v5 03/44] perf: Move security_perf_event_free() call to __free_event()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the freeing of any security state associated with a perf event from
_free_event() to __free_event(), i.e. invoke security_perf_event_free() in
the error paths for perf_event_alloc().  This will allow adding potential
error paths in perf_event_alloc() that can occur after allocating security
state.

Note, kfree() and thus security_perf_event_free() is a nop if
event->security is NULL, i.e. calling security_perf_event_free() even if
security_perf_event_alloc() fails or is never reached is functionality ok.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3a98e11d8efc..1753a97638a3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5596,6 +5596,8 @@ static void __free_event(struct perf_event *event)
 {
 	struct pmu *pmu = event->pmu;
 
+	security_perf_event_free(event);
+
 	if (event->attach_state & PERF_ATTACH_CALLCHAIN)
 		put_callchain_buffers();
 
@@ -5659,8 +5661,6 @@ static void _free_event(struct perf_event *event)
 
 	unaccount_event(event);
 
-	security_perf_event_free(event);
-
 	if (event->rb) {
 		/*
 		 * Can happen when we close an event with re-directed output.
-- 
2.50.1.565.gc32cd1483b-goog


