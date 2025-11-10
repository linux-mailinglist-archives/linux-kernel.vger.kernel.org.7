Return-Path: <linux-kernel+bounces-893524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5CDC47AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 196E24F02C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB5E320A3C;
	Mon, 10 Nov 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKVhXEMX"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353126E706
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789146; cv=none; b=p4m8A0daiW8mv19XhTYjwK46XXV5JMRRIy9lwhXA4P2xLUgyKplnhe8NXqHcMrhSU30KFW+1Vy9tlfVTBhY0WeHX+9RZAK1w74zLyvDFQlRO/47Bv6XSsjgee5SIhhrhud8IKZG8S+ZB7jghlxtTEGC8Wo4+WqG7SPDCxUDTR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789146; c=relaxed/simple;
	bh=PPL2SdLK8PmSDvO6BN4piAdIr1VAL+6Gg9dslowyosI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZGES0ZfLuyJNU727ahRSpCHAY5wBI2Bidh7Ffgu2RrcwdSFSqyE97P5JjbSD34pKrcqzalpQvFj8xEBDp9mMDDL9AB68XzayrlrXS//+ofWB0AzdwKR8iPGwoA07kw8vPXU2TIMb20D9HHvO8tWcPNwhZawlYaN3r9Y0T8pOuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKVhXEMX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3436e9e3569so4963191a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762789144; x=1763393944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7AEvXYOaN64JItQuWNBgAvlkHv3cc5xwvMT5feppTYs=;
        b=pKVhXEMXE15mnv0+98STna0T60z5ewHVgQc5ouqAVJTe/PjPFajugDnyPSYR0ysyK6
         NWmiLjQYTNlxIQrX59p4CJ1qFn11TxfFgN1vTZ7Sg+59oyw267+HLghMwc3lrIPqIZgG
         HEA3BnMItxazmllBlSUmmRgVEEbRO997cNx1QjvsxdiGi6ZkuvsKfTtmLBmTVi3NyDoK
         ejbkhQHKsGFlgDON/6svDiCS8Mi9R56i8VCXFfgwWxAGN8/amkPFVTtSqUM98vlkmu3z
         p7MgzXG9doczqHBS1DpcqmKxaxS4J4avyDr4dGE7V4d15eAP/4EWzOA8/dEQv0TBlLfC
         Q1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789144; x=1763393944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AEvXYOaN64JItQuWNBgAvlkHv3cc5xwvMT5feppTYs=;
        b=vvit0Z7IMT8n4vzz8eXEuiB2vpLym04p37YhVy5jjbEJlnlYCGy53An37D87eb99i0
         3eFAHnxWG7AGkXQj3wlEFY9xpqBRLbX5KN4n/e/ruHmqGuwUelFbVmS/boeXhEhNZRfs
         zNiDZwVJMwKRFuUCRp0Fd12KCrAN9GdYwUZPg2D+Pd6S91l2kNEWQv1CGq2EfvejMES6
         o16YDiR+UEnNFoenWcw7hv5xh8QTwyrAlhkw9+lQ2boGe6r91q6ayXUcI2y6qOuRnFRe
         bYnoDl7wEXuoe24GsjsnjC3axyuDGCbx6Eoxq5J0iLi3MHXmQviCbkrskcROtUzmkyBD
         qBTw==
X-Forwarded-Encrypted: i=1; AJvYcCXwXCXm1wVr0wOl5PEyQQCXkqscJGi5FgBuiugyZyrjVMxXOeVVuAUjC0cr4+Hd8NqVuHKY6Ghjn7xrM7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjFMvPu03rjzuZt/+KrAbKULgvyvPWQum+z7A5Ous6vFdGqIU
	QKpxZfOLVB7jqRPAfO31/m5EFhzI7l8mpi1r/BKxcqS/htbMpZWP5/gMA+veKup5X+kXrkl+WdB
	92SmgAw==
X-Google-Smtp-Source: AGHT+IEJBxP6dqiRUZf4jx9C4qqYIsuUEh+aRELI5Lvs7Iom2rN6WMbD0iv/Wsu2+Py914cxV3LOn+fxxLQ=
X-Received: from pjboe10.prod.google.com ([2002:a17:90b:394a:b0:33b:dccb:b328])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e707:b0:340:b1b1:3d28
 with SMTP id 98e67ed59e1d1-3436cd0975cmr9112633a91.25.1762789144323; Mon, 10
 Nov 2025 07:39:04 -0800 (PST)
Date: Mon, 10 Nov 2025 07:37:23 -0800
In-Reply-To: <20251021114345.159372-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021114345.159372-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <176278830538.919221.18305930787987749373.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Move the misplaced export of kvm_zap_gfn_range()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, Kai Huang <kai.huang@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 22 Oct 2025 00:43:45 +1300, Kai Huang wrote:
> Currently, the export of kvm_zap_gfn_range() is misplaced, i.e., it's
> not placed right after the kvm_zap_gfn_range() function body but after
> kvm_mmu_zap_collapsible_spte().  Move it to the right place.
> 
> No functional change intended.
> 
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86/mmu: Move the misplaced export of kvm_zap_gfn_range()
      https://github.com/kvm-x86/linux/commit/6422060aa9c7

--
https://github.com/kvm-x86/linux/tree/next

