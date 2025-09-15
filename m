Return-Path: <linux-kernel+bounces-817757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4FEB58628
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27551B2176B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036402BDC2A;
	Mon, 15 Sep 2025 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I08gPeZs"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0F62BD590
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969035; cv=none; b=CK7Gtc77LKrDN6OdyFxrChPPjsYGXquR6bEKZNz7vH+eUPWGeny0mf4qViGruaZpBi2AN4fF+ka9WHbz9pQeGrTZKA8DwctBOsspW1S9CvGVLQyoUgCeRJdfuix2Wrwc83AoUsxAzdc+uWSV76KRxYwCZ/4ynT3QSfbHC1dEQJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969035; c=relaxed/simple;
	bh=D0i2y553ts4zAdqWL49gsYITlggsfUc3LBYrpV4lZ44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OAg7VqY/Eu+8vJXuvEDAr9KuvtZIU7qHxdvixU+xC3zsuqscp4DzA6k3lPMdxAQe0ZI4mcMpz8gw3YmMHqTYxPswxKUZ+1DqQKRM/H8tjREBec5bb+WTGd6Quu0o48qh2ZbQpUUIGpMJOv0BoIj3Qvfpbags2KqjmzU93gvdMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I08gPeZs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32dd3e922fdso6741469a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757969033; x=1758573833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNZA4uufZxwJqfLrll9YsId4o3B4WIEaJu/+Ldkd6qU=;
        b=I08gPeZs41zLyiaEqmb1YINKYZl+hCF7zjDIjOtBUmJdL4i99WTxofFNDzxOApyItz
         4peii7AbGopi0ZNu49vqEnvYeLXD+eRNKRa0fnB3Y4hLNQqtQl1sPB60Bh8COR26FSkg
         FS8UnQ43SOug8IeH08GEJt3v1S8B22xFx7qkJpwHfcyPgC4QrbnFH9Jb761NddS94GnV
         Pibb1WXGk7l4pYLytC3FXhMWvzjsF6I7LPGiHx6r+oN8MvU18n1puGPvj5+/dhi3Maqn
         hJHAhWFnZdsr+vLbohMTFQH+YVn7ddyF3ic7o7ct40P+1rsL/tW1RyB4hvC5fdlVzcCK
         QRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757969033; x=1758573833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNZA4uufZxwJqfLrll9YsId4o3B4WIEaJu/+Ldkd6qU=;
        b=cpQekV6LK7HnN2FiUvKrP3kcJCSOIqDpp0fq2YSFGvlgLbSxEvLD9PaaH3m7H9/UKn
         +c4tLnpTCccRoATMSU39/U6PAnaPMQybWxVx7YNzovSRzJA+QAkC7FZfwVRymwzrSopb
         /rb1eoI0JRNwxamyrmiT/ZHJuIf1g74802p29Gou2P80yPYwUCVzS7y1cQC97JoZw/b9
         vog2+ErYJMbRfV93BFG+c2NEoykvW8RYYQpUaoOpSPKY2j7UCiXaQwecLm7oAPAuktuM
         RNCuqsKm0Ut8XqFtpyRi8PQvyl2paw7RTTdOW537exInshYFP+lSDz5vHe5N3fLBeMn9
         ZRcA==
X-Forwarded-Encrypted: i=1; AJvYcCUrwUW6R0RKIua5iTPSnMUzY3dML961cfnKC+4/Ed7NmOqURXp+WYCsYsFIde8s/RNgztSJd/SJcDirwJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVd3dpk4F7CymvXQzVlVt36two0UDNQB4aLAzWYdUZ7sijD+T4
	oH/XJYk6oeNsJGdGJIzTjI8AKuQ3wuZ+a2phwP64FCcPEqItGWOKibNlbYWySLU16cNPOGNfCU2
	bnc+xXg==
X-Google-Smtp-Source: AGHT+IH+uR1I1C2NAlNo4rUt8n44OCfJyHV5fHAdjAp78kGEwsK1T5RTEklC9dBKFtDNjZXaGXlVOdusr4s=
X-Received: from pjbsc7.prod.google.com ([2002:a17:90b:5107:b0:32e:529e:ca6f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5107:b0:32e:528c:60d5
 with SMTP id 98e67ed59e1d1-32e528c62fcmr6530244a91.29.1757969033304; Mon, 15
 Sep 2025 13:43:53 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:43:51 -0700
In-Reply-To: <c6d81bac-8540-493d-8edd-18f5d52cf7ff@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-26-seanjc@google.com>
 <c6d81bac-8540-493d-8edd-18f5d52cf7ff@zytor.com>
Message-ID: <aMh6hxdDsWmeWrXM@google.com>
Subject: Re: [PATCH v15 25/41] KVM: x86: SVM: Emulate reads and writes to
 shadow stack MSRs
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 15, 2025, Xin Li wrote:
> On 9/12/2025 4:23 PM, Sean Christopherson wrote:
> > From: John Allen <john.allen@amd.com>
> > 
> > Emulate shadow stack MSR access by reading and writing to the
> > corresponding fields in the VMCB.
> > 
> > Signed-off-by: John Allen <john.allen@amd.com>
> > [sean: mark VMCB_CET dirty/clean as appropriate]
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> For the shortlog, shouldn't we use "KVM: SVM:"?

Yep, I simply missed that goof.  Thanks!

