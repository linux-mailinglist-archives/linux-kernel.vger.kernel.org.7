Return-Path: <linux-kernel+bounces-852723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA324BD9BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E8418894D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78DF31354E;
	Tue, 14 Oct 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zjg6FyR6"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78252D8DB5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448502; cv=none; b=mpbzZGykJrpYbzR4eo9FRUbLQDPS/YsClhd/pzdGR6qem5y2SMv4JWIqwX45JbObew+NWYc5/Fx5s5hbgpFtURkAaPtL+U7aMaYfOwTXTcXoAs7R1i0wkLTar5zFD64IBbqk7bXL7PYdOliAzursA/b2GR11mrQHNEC+rKX7QX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448502; c=relaxed/simple;
	bh=TORf89kxAPruMWAxwwZpkmqfRfZXSRcqcOCEdZf5Ed4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pj9PIWgmQjxL9aHdt6LQAaKDs5VJvNA0XV3Bj318gZXyP6uVVPSyYZUgnknkGTsRW1rHI79RFrLnl1YRnB9vh4HHVkEiT9DBubxx6KgwYMMXAharirNEg/yCJs7cSb1ulAclDp2nYuQOeO6GBfWD1S9LAOb/HtIn4wwzD5etYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zjg6FyR6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befc3aso11472907a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760448500; x=1761053300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KRjkMfm2bP+2xhdA92yWGD49fzo6BPa0LuWZXvUPrxA=;
        b=Zjg6FyR6ONCBw1ISq3+aIhtFrZLgI10cie7Y4jQLDEGgf0lOCZUo4OsKeXgxXP5V1I
         zYmWno13J3Z0WEShnXpdr6qnHFEvJgsBQFeAx8FJHI0kAk4U55R6BrcQDBDdnHPh5P0Q
         ka4cjkUAP/tgEZH8iq0Us5jOKljfxPXSuZ9z/hyW8tlJYThPZtNlBTWhLbhV5BoUUPLb
         v9VburUslRD1CI1T7fAxFdwCuIUWAj0+Zu3fJeWCHT7FvEG7FzG26Nt6WVkv1dpCoA8H
         3LRbZk7M2IhCQojl3pAeADbsb1g/iFuc55tAwwDos1uQn49FgxUK5Y7FNuBHooDDYMAE
         c+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760448500; x=1761053300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRjkMfm2bP+2xhdA92yWGD49fzo6BPa0LuWZXvUPrxA=;
        b=RytWXLLH8RTglEngup9dH/KJyQ3gmHhlFiHPTCTs+X60JMNvgK5C3oSMrHpmvnxnZA
         xC44SBkOPyNPX+ey6Ty46iYWKsB4BeE8zaScnVr9JKZJLqxiSZOlYtOkLt4d5SSBxa/U
         u/QQ5cNWFxf9mYdLKGldOBq/3Gzc7k35Z1HvqHOQOoC6FTbPL7QPULY1tLPWikbaDhhM
         l/7YBFp7ilja2dzQOkMrfqa5GFOY1HoQBYgzJ1WNem05DSfogHlpjRTBt4iNk/CAKff/
         KaWtY+1McUTCNG5pDdLZuGB7ueOfkNlPIA5hmBDhmV+ueu9VbL0zS6L8l8l87y1kuGia
         jbYA==
X-Forwarded-Encrypted: i=1; AJvYcCWCShEzJKPkZAtZBnn3TTkDdKf8EBY6snaxLNoJTNvchm5b0MRyC89Z0d2OkTmwM1NXf9OPLzmVIs5xD0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/PJpgdYq95Oyts4xHHnqGMUS+3zK73J8/14k5CylpSfgJRIY6
	rTgkb71soap/r8TmlICNGhn7zqnDBuM7dwNCLUOynrQb0AOqkvZVQdEmhyTrBI3TlY6Ah9/HVM7
	LXLI4zQ==
X-Google-Smtp-Source: AGHT+IGVUDXfEjxHF3D+9yDOYD8dNTWDN/VoE4bMUUCel8CPLfbdjARtih4c5//0jV2kl8OrGxXOC3GTZro=
X-Received: from pjbft23.prod.google.com ([2002:a17:90b:f97:b0:330:7be2:9bdc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c06:b0:339:eff5:ef26
 with SMTP id 98e67ed59e1d1-33b513ced9cmr34861576a91.30.1760448500020; Tue, 14
 Oct 2025 06:28:20 -0700 (PDT)
Date: Tue, 14 Oct 2025 06:28:17 -0700
In-Reply-To: <528d8293-a1a0-4d4f-87a6-e06eff7c559a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251012071607.17646-1-shivankg@amd.com> <aO0G9Ycu_SlISBih@google.com>
 <aO1CGlKGso4LLtS5@google.com> <528d8293-a1a0-4d4f-87a6-e06eff7c559a@amd.com>
Message-ID: <aO5P8TMihUZZaYX-@google.com>
Subject: Re: [PATCH V3 kvm-x86/gmem 1/2] KVM: guest_memfd: move
 kvm_gmem_get_index() and use in kvm_gmem_prepare_folio()
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: pbonzini@redhat.com, david@redhat.com, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 14, 2025, Shivank Garg wrote:
> On 10/13/2025 11:46 PM, Sean Christopherson wrote:
> I see you've already merged these changes into kvm-x86/gmem.

Yep.  I need to do testing (not really of these patches, but of other things I've
applied), and then you'll see the "official" thank you mails.

> Should I resend these patches with kvm-x86/next and --base, or is the current
> version sufficient?

Current version is sufficient, thanks!

