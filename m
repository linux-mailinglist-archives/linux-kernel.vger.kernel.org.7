Return-Path: <linux-kernel+bounces-763573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0BB216D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433557AAEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD382E1743;
	Mon, 11 Aug 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6hqc4XA"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821A2D8DCA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945628; cv=none; b=QXVqkV71Hz1np7t4ZsTMNKGpU0w42blaRX9o2uiLERZtFNc7dZSA0GRicdDJdaPL5oWJ2MFRDvR2LjgNbHWgISf8cxXoNQ021CZgZOc59zghc6dTNGPkc2w/cKlYwZwRcqJR2Q54/4KeR1IDU59x1Haqi1AZgYcIHensjWQBN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945628; c=relaxed/simple;
	bh=JAqQRpQuRD1gv5XSPrDmnd2nskW03QCSTIn0+0VPuag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W/DZshurHQsqSrTf4EOQbFr4tjs4e5nHNK/mE+W9cq80u5pV9mInAQrBwLS1rHHJ8pHAQ/vpVVQSwMgSLSj/PG71KxUFdWO4HM3HjcluH3sbNTs1rJ5mfyVxdrXEPhy90Jbfd9IEz5UZJ/MOQ/wAeVZWxHnfFyX+sdhPJnz2yrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6hqc4XA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b42a54b7812so2661511a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754945627; x=1755550427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIjVfeNq+ApcEX/TD0b/1d8mPe0JYmLtItfn+lVbGBE=;
        b=f6hqc4XAtmSp4LaqoiFu1kQ0VTvQMysRApUX5E8TFOKP3Np5v/MvJU58j4Lm0Gw/yi
         6tkZM8viSAmLKg7oUBzi6lyZ0QjS2OgbjvYibxvuHlX/bt6IoNNQJXtHMpgHGOoxfcPP
         2JJVvUBdtTM36fYWRfFMsdiKuNhtq+ZKal34tgk7Tnqho6K4WNJ8HLWpR5NhKAd8I7jf
         GRSpsAqF4753xLoJrtEzMk1dDTuY9jzhSbWetXXGxMUozUKxNznrCqwO+USMAK2zRvLL
         NKZx0L5vGwAiaUAdNGtvLyiBE3Pxe03AOKG+IitN+E57sxSNZb+zW2vRPHh53YvesJtT
         6W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754945627; x=1755550427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIjVfeNq+ApcEX/TD0b/1d8mPe0JYmLtItfn+lVbGBE=;
        b=JOT4/GuxqRUoTKQF53IEwx7CC6l3gUld8uWyufarEOddGdHv4v//QTb6HFJkw2HbK4
         DSOJLPtJHZE3ZOrMP1HucSiSp2EEdMssbkJa4/yahM8Bu86cDOQvGkgUFo/jBJ84yFGE
         5ER9s6lPfRQSGvWg01kUQw2/+tafK7kzvgAvMg7XFFx8cxipAhC3VoOCkXOnh/45B3pm
         0QgBjveo4drhnGbBm+zGwlVzbudUY9ZFCJ/fqKdt4+nPNKB484phuyieY2xMbnnTpVad
         DnP8YrkjLlWY/fN5SRgu7KiVwOY3HbYSFh6wzdisIep0TXb+7NADLRtUj9JXHMPh38G/
         4KwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMcDe9hRdu75np1wIYfTLvNDplLjJIUaPXZ30AtVeemQ2IuR0YQmtRnvZya7ZOjHgSv8Wct5OPehOnkys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTy4CkL0Qq+YWothF7mb2hj/uiNWuZBiYTMX7oy3/BhfezBbO
	cB8fgnTlK2lr7AH8uDK/xESPGAyNbrOeobU1o62YFviRGUHvpo2IFD8S6D5sdi4BfCiwHThJGC8
	aarVIFw==
X-Google-Smtp-Source: AGHT+IFQy54dyug1fwyF7mFE+kG2LTj1gs6Ocg/a2BRYAoLkWItNyzLA1YfJte7cQL0UErIPYnECfSs/jDA=
X-Received: from pjje11.prod.google.com ([2002:a17:90a:630b:b0:31e:998f:7b79])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c7:b0:220:ea90:191e
 with SMTP id d9443c01a7336-242fc1fcf98mr12784565ad.4.1754945626697; Mon, 11
 Aug 2025 13:53:46 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:53:45 -0700
In-Reply-To: <0976e0d50b1620c0118b8a5020b90f3959d47b4a.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <aJoqqTM9zdcSx1Fi@google.com>
 <0976e0d50b1620c0118b8a5020b90f3959d47b4a.camel@intel.com>
Message-ID: <aJpYWVvNXjsewl-b@google.com>
Subject: Re: [PATCH v8 00/30] TDX KVM selftests
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "sagis@google.com" <sagis@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	Ryan Afranji <afranji@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, 
	Roger Wang <runanwang@google.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 11, 2025, Rick P Edgecombe wrote:
> But Sean, if you want to save some time I think we can just accelerate this
> other reviewing. As far as new-fangled features, having this upstream is
> important even for that, because we are currently having to keep these tests
> plus follow on tests in sync across various development branches. So yea, it's
> time to get this over the line.

Yes please.  The unspoken threat in my response is that at some point I will just
start NAKing KVM TDX patches :-D

