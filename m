Return-Path: <linux-kernel+bounces-817953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE7FB58977
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F1EC4E26FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF162239E91;
	Tue, 16 Sep 2025 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4aTSkGX"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3AD1FF7B3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982566; cv=none; b=JXfDmGFVe7Dioy/MhL+RZeKNeRlPqv8TSxjTfFxc9lc2Qm4x/OWEoRNGfe3aWjv4Pdzb8xpruPlA3CynO6S2AgrtpSS7pZqQMeizXppzpAV0hmElHgPzaWafnLY7X4UAAi7XuJoBvnPFdWykgWmod2+O0m74ysmF84ZySH//lBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982566; c=relaxed/simple;
	bh=fZMcGOq8pzFqzBnyHPQZyj8sd8INTo/alNIKN/HnQlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C2Z27QVd1TrVZTJdOYogGPBDSG8wszs1uHNCvgCdPtHovGFDLbZ/g5dNbLASJlSjzhaRBZ7fEaDuu65WM2R/qY9GVMH19qIJKHQUubhY22gfy4aovehmTxZOF13iXJ7rlI2ghMlc7Mh5tkfraJrNf+JWIAVXAwT6QvE5norn7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n4aTSkGX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ea7fcddd8so33667a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757982564; x=1758587364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=59afqtQ1ZW4R1cwGm0JEKyCwHwkB3xWI6A7bm2gudqM=;
        b=n4aTSkGXoc/GlinVw9BLDYsvwuGIGuD/7aef/LYWBhsmhKyUF++oDLXmhhJzLIxOAi
         nU7znwjhnMvsNuOz/O/HkaM9mjgAAK4eboT2K6w9ie8Wi6cLNd9gslMLuqgzFsPmJFyR
         DNEilqhBVN5cuOkcyqVVpu57gQw2vW0O0sGqxs2FFW9fyocsNuSYOkAC7XeIrbu5AO12
         nNrDx2cDbtozMlQ18b0sxnljvn5qZBtwh02vSVq3BiTz3xo5XUuqQm7DH8YHtqrqhXlz
         bqJdGZ1M/4Si+lZa6NcW3US/KPmO11pND5wEDrB0JA8vvxrTUaZ++ZNLW19pi7yTiNpY
         v3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982564; x=1758587364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59afqtQ1ZW4R1cwGm0JEKyCwHwkB3xWI6A7bm2gudqM=;
        b=e+nTIGgi3+Tv0ZyzcM5VWHo1oWka7y6Fgfnnod74WuZsvqj3+ISS2CKprCmlhPoaij
         bwoaU8MMJcJglF7vCPXRaq5FOkoV2JAVqMyerTDqD1/qgeF3aRAVeXftATCK9gSUk6lY
         GUYMawcNhZPiMBdppgB642Cy7MI2sWAzOH7a8RW+NgwV3ug7bCBadMwizRK7z0qlZqmO
         E3iUaoQQIHeZuivK3/15+I+xIBsfr5QK1+km1FHnk4QwNMUiBn/CFEvc5GLquXylW/5R
         wdBZBrWheuY3WNRrmwfLqCxY+SeIK3EbRH5kz0K7WgYZVytxvlJPgpOu4Q4UGvumjveZ
         yv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGinqfaGccO6YMJDwa7QP3jnlfDKIMt4SRaAxb2TCxmVZzlDfoCxBXWCHDzh8TErMIP6DOkc1dzCawBEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5jtEzD4jhcKW8bSkRxFz3uVFiprb4ubsKj/8AovVNCdwgsA5
	q6ErJN1/vHUpwGtBAvVN0fvLjWzko4x44Pk1x28u50T8QCzwfQLoPGyi6ZlEWKuI0M+HEjqlkcK
	UI/E/QA==
X-Google-Smtp-Source: AGHT+IHdRyVQ1cTTutce6si835oernHf1LkOFl/hzxk2zcb+YDP6Cz1iCOnHtPpotb8+e4+NPdghVuEgiw8=
X-Received: from pjbsp14.prod.google.com ([2002:a17:90b:52ce:b0:32e:9dc1:de9e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cecf:b0:246:cf6a:f00f
 with SMTP id d9443c01a7336-25d2647015dmr196452855ad.31.1757982564063; Mon, 15
 Sep 2025 17:29:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:57 -0700
In-Reply-To: <20250903002951.118912-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903002951.118912-1-thorsten.blum@linux.dev>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <175798208020.624679.16533836332687059035.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SVM: Replace kzalloc() + copy_from_user() with memdup_user()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 03 Sep 2025 02:29:50 +0200, Thorsten Blum wrote:
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify svm_set_nested_state().
> 
> Return early if an error occurs instead of trying to allocate memory for
> 'save' when memory allocation for 'ctl' already failed.
> 
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SVM: Replace kzalloc() + copy_from_user() with memdup_user()
      https://github.com/kvm-x86/linux/commit/fc55b4cda00a

--
https://github.com/kvm-x86/linux/tree/next

