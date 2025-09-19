Return-Path: <linux-kernel+bounces-824960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AB2B8A914
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7757C56801B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE1426D4C1;
	Fri, 19 Sep 2025 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AbYwJ5uw"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3E1D5170
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299462; cv=none; b=Menx1asdeHzcGUMR7DcPZ7LvdJiEwLUqMSMUuhTXRAHCd+Htwx+SRuIm9wCNQh53ukswiXXiGk9eXTYzynkn41TPs8aggGk/vt0n5GUtk11lTWimQsfJKu/HxEz0DGh7q9c9/rg3EQtUDwVl3FZAn+MYnoMcysv74vEDI72rsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299462; c=relaxed/simple;
	bh=EbJ4AiA8gLkDFOFvFbJIyBt++XxJyA0dcNP1PTrWVv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ckBr8cX9ziYwUajjPCfVS8A+8IKtqbQj9LLzTxzPJV8X5i57HYUxxNecp7oOt5yNPplR1soa442tgeCtS6lA9nesDtY2L50kCOg/pkKkFBBJ2QVmGAkjZbZxluwY+DSB+8e5hGaFfUM5H8+VHC7WCCRoVhiNoDhKO4pi0YHF5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AbYwJ5uw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329c76f70cbso1932074a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758299460; x=1758904260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbJ4AiA8gLkDFOFvFbJIyBt++XxJyA0dcNP1PTrWVv4=;
        b=AbYwJ5uwmx4DN1HxJ8vehZFo/QP8vtxUshOdVVMxQYS5XL1JfM0N8WuMKnCazcABH0
         YGFUo0Cdim8daz7EOye8gvi5K5rI+oJVI/G96zPb1wOHzwyMmPTZ63qVNg/E5t/Qu9C8
         LGHoUzl+SJaDMEaBJ+PFxtVIl543EEeTvaZgEY+ARYdapguIZwAYyT+/+BcFdTQhJyr3
         6rYbCUGqBqU0ryCTMht7Ck8kimbRolAFqKN25+wy1tcQZxMsOT8jG4kP2ARUe4rKnBd4
         4grtkdWjMWovNVIAANNScNS1vYYqPvU6w0SyZL9qEK35P6JASN7CMD+CoLt5HgUbsUrC
         uZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758299460; x=1758904260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbJ4AiA8gLkDFOFvFbJIyBt++XxJyA0dcNP1PTrWVv4=;
        b=ZzFzOhmYzijpQvXCIqjR52cBNCaYCOEEK2PzBWgMbZ9xVBignFkPqxciBDX/lXURnF
         6ylh/ikCgOfbi+5WiPL5gYLX2oAuP8CIlQDLHSXH6n1wARzza7IKUGf24JYdMx6h0uRb
         WUk8AKrEd2hqPueLhzEJkR5hK/2bC2weGVx1YWJ9sVpDw6DOXgIrx9jKtc4XxezVEjdM
         KwQdkseurXQiENMcTOkpKmNxv4n/ch2CrW2tM0VsqiFuYmYXfHXfZjxMsgsoq+wdIDP9
         YmwuHXvGwBzkz94x75Np5VEUZq/sKQpYn2UOQvfzN15Gp315cZmAOYwcWN53TfNKzDFq
         HJWw==
X-Forwarded-Encrypted: i=1; AJvYcCUGoIaLZKTjFwlDZud7uO4n3EL79WLaN8KcvD9snh6vUFpfLQf51VnMM6bJJ5ghz3Sw9sWI5RaxF8L7JqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+1aGOnI+NT1PEWsqJlwIsS/FQGraLKQFEQfDHCYoTWNdsvAk7
	D3SFphSPJ/hNUNDfsA08eCLtKIjHfPTucCBNAhOxDp+Z5L1p04KLH7EmRLvJh2393zRx+LXX3Vl
	XfRYCJA==
X-Google-Smtp-Source: AGHT+IFAEj+AOk7FwjvfWv87R1UQ7I7WVeLJxEs6CcufpI2/ZHy/EMe9RZz/oMxp7jA0TMz9ClDjylxKb8I=
X-Received: from pjbnd17.prod.google.com ([2002:a17:90b:4cd1:b0:32e:b34b:92eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5107:b0:32e:d015:777b
 with SMTP id 98e67ed59e1d1-3309834bf22mr4704369a91.18.1758299460333; Fri, 19
 Sep 2025 09:31:00 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:30:58 -0700
In-Reply-To: <aM2Dfu0n-JyYttaH@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <05a018a6997407080b3b7921ba692aa69a720f07.1758166596.git.houwenlong.hwl@antgroup.com>
 <9da5eb48ccf403e1173484195d3d7d96978125b7.1758166596.git.houwenlong.hwl@antgroup.com>
 <9991df11-fe7c-41e1-9890-f0c38adc8137@amd.com> <20250919131535.GA73646@k08j02272.eu95sqa>
 <aM2Dfu0n-JyYttaH@google.com>
Message-ID: <aM2FQiC7_8tLgKgd@google.com>
Subject: Re: [PATCH 2/2] KVM: SVM: Use cached value as restore value of
 TSC_AUX for SEV-ES guest
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 19, 2025, Sean Christopherson wrote:
> On Fri, Sep 19, 2025, Hou Wenlong wrote:
> > On Thu, Sep 18, 2025 at 01:47:06PM -0500, Tom Lendacky wrote:
> How's this look? (compile tested only)

Almost forgot...

If the suggested changes look good, no need to send a v2, I'll apply with my
suggested fixups (but definitely feel free to object to any of the suggestions).

