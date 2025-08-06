Return-Path: <linux-kernel+bounces-757937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D610B1C88A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE24D18A6659
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FF428FFDA;
	Wed,  6 Aug 2025 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3q975gPN"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6828D85D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493556; cv=none; b=O3030kv+nuMQGrJftKrGm30ZfbsCjwTBG+JGi2e5BnN+cXNu5yklwWHNi08U0Uo0mn5+HrRg0bXeQDyksPgHLUiyTsoIdipFw6qCjoyYgmHBTixr+1k6lwTMvgAjx+drYOo3ToyjH0BiWcdMv2V5FyrARterKX8upN3DtA0Oxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493556; c=relaxed/simple;
	bh=+SzIyp+azHzXi3wmerkgl+OB8gD77zXbcUhm1m4L1GI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U+dHEEmlyPNf1wa0+XxJ6cksqfL30c5YlWU1MtAKlS+apzDFCwF2aQK5NBfZkv/mPw/FYFs8MfjXCugfF5YbRd+8uKeFNA0lPAjTxftsuWHUryxLyauyqbDgcmlFJDFmwtsbciL0HmuJ3ex88W3/gWfyK5zhNz2Mz1bE0GYy39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3q975gPN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31ed9a17f22so108063a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754493554; x=1755098354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDQStjMluPm00O/x8xuIBu0JMlXP4PdE4vThsGuTUgQ=;
        b=3q975gPNJEpXZwdQD64N64osa5ya5bwW5nSyGv0J3n4O6nYpCYXTicAURw5rR8m10I
         3wDJh3WGhau1GZTWTQCPoQYXGygtEaaa6HJUhtdj74OTgup3NJIMOWlhB/QBL0dJiRhq
         qjN7jfKpWNr6fJKxO4K2lFZxuPquwTFdQi2deZVfv6oy8i+zJ8n7NTNT0E4DntUrZM95
         a76cE7i6TMQkB8nLNDoclWzf4saBWiOgHHQYNLBph3g86cgUNE1RVDsPB753edwai95h
         JyXXqahOQ+4n/clG94gMEkvm635KcTk661GBb9aiRpZn89i30D6RhEMQZvuATfW4Xj74
         U2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754493554; x=1755098354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDQStjMluPm00O/x8xuIBu0JMlXP4PdE4vThsGuTUgQ=;
        b=ozkVAadmWZULcD3OP/nF7tivgdpt+16Fx07aJXveHePBc3/yP7kHLINe1rJv+ysKQe
         +4cemp6Nm/8MBtsdBNvkxRZ+Ilk6nWHt1coKXcViBc/AzoBcdrSx++KbN1xw0OI2Qb46
         ii9dTemy8jE5PZNVa04wurscs5XcqNEyzMAwv5zzeu5P0QLrsY3+VXRmFm0sQPFPmxFh
         UP1RcPClgq6Om+m2rs3gnrvV6mPYtSJqy5uTliIMv5O0V7AphHJfSs/wC75Pa8SwypSL
         LK9cOjQn00dKUHCEXv0/S/WWvnufrqgpU2wJX0CHpAl6hO4cJBoZPpTpuVCjakfWvakc
         VrBw==
X-Forwarded-Encrypted: i=1; AJvYcCX/yAP53NOwuEQYruXURSBGSrqOVRL0mdjj5YH3D/jkTFv0a9qT2IrLcXkjBnw1k8LbZXVSSRLbCenVW+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbwv6SVF7M8YO/c/iUckKqUo5dpQDGIvgfdCXDesn6+KuqGmoY
	6UkSa9qVixapsYuko9LPzjNypZQP/SO8EtKblkUQpXYGuh61oq93djz9y+XKfdX3PweusuHn++w
	JeOXF9w==
X-Google-Smtp-Source: AGHT+IE0ws3A1oPMpeyK+BWoSra1biTwg8ZIx15Eh9OYdEDbAXwg9YusjzqGIk7Bj9JXcN/gIQTc0EhEi2I=
X-Received: from pjx15.prod.google.com ([2002:a17:90b:568f:b0:31c:32f8:3f88])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d607:b0:31e:ebb6:6499
 with SMTP id 98e67ed59e1d1-32166cc68fdmr4543810a91.24.1754493554269; Wed, 06
 Aug 2025 08:19:14 -0700 (PDT)
Date: Wed, 6 Aug 2025 08:19:13 -0700
In-Reply-To: <7f1aaf559a4f93f63f8e996938cfd957e151cb50.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aFxpuRLYA2L6Qfsi@google.com> <vgk3ql5kcpmpsoxfw25hjcw4knyugszdaeqnzur6xl4qll73xy@xi7ttxlxot2r>
 <3e55fd58-1d1c-437a-9e0a-72ac92facbb5@intel.com> <aF1sjdV2UDEbAK2h@google.com>
 <1fbdfffa-ac43-419c-8d96-c5bb1bdac73f@intel.com> <70484aa1b553ca250d893f80b2687b5d915e5309.camel@intel.com>
 <aIv8wZzs1oXDCXSU@google.com> <3f39e6f85341e141f61527b3192cefde0097edb8.camel@intel.com>
 <aIwB6X6cw9kwgJzs@google.com> <7f1aaf559a4f93f63f8e996938cfd957e151cb50.camel@intel.com>
Message-ID: <aJNycTvk1GEWgK_Q@google.com>
Subject: Re: [PATCHv2 01/12] x86/tdx: Consolidate TDX error handling
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	Kai Huang <kai.huang@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 01, 2025, Rick P Edgecombe wrote:
> On Thu, 2025-07-31 at 16:53 -0700, Sean Christopherson wrote:
> > On Thu, Jul 31, 2025, Rick P Edgecombe wrote:
> > > On Thu, 2025-07-31 at 16:31 -0700, Sean Christopherson wrote:
> > > > On Wed, Jul 30, 2025, Rick P Edgecombe wrote:
> > > > > So STATUS_OPERAND_BUSY() seems like an ok thing to try next for v3 of this
> > > > > series at least. Unless anyone has any strong objections ahead of time.
> > > > 
> > > > Can you make it IS_TDX_STATUS_OPERAND_BUSY() so that it's obviously a check and
> > > > not a statement/value, and to scope it to TDX?
> > > 
> > > It's a mouthful, but I can live with it. Yea, it def should have TDX in the name.
> > 
> > IS_TDX_STATUS_OP_BUSY?
> 
> Ehh, would nicer to have it closer to what is in the TDX docs. The worst
> would be to read TDX_STATUS_OP_BUSY, then have to look at the value to figure
> out which error code it actually was.
> 
> Maybe just drop STATUS and have IS_TDX_OPERAND_BUSY()? It still loses the ERR
> part, which made it look like IS_ERR().

Any of the IS_TDX_xxx options work for me.

