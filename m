Return-Path: <linux-kernel+bounces-819507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59429B5A1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9E91896F06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4952D9484;
	Tue, 16 Sep 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEMcJ3Gv"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1642356B9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052962; cv=none; b=dreKIcr/G72U8bOccNOdIYR16c240ENl/5gpHG1Jfclq8+eezhixKwBvhBbTrpP2fNrlhztYWuTJdnYQ/WZKJjdUYWhb/Oxjq4S1+U91rh+JCrMBJcQETfxM2JrzifsEnttX3QXHcjsnMx2nX0hnDqduc2cScZecFvj31ZcXFlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052962; c=relaxed/simple;
	bh=LLu1AACh5q522Nr37rB3izBpVJgz0C5vXI0RUs0TrRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DCYIsgaEV422YSek5j0b0nXXIs0wToUpm1T+wknse9XDNOLtqqCZ0Rb7z5sqZPPe5JnqvDVrCFlDVy7aLvSnZRi96LxHVMIgWw7uV4by+qft7eoOKhSsq2pf/k8qKTIXYBXUl+a7ScuICZfc7f6W5Omg9K2Hi3i6S4ngRBecVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UEMcJ3Gv; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7761dc1b36dso7233787b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758052960; x=1758657760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDPBVUVtayrtvgwZw5aJFImyZz5WI+omxTmlAGFmthM=;
        b=UEMcJ3Gv8MCrq59TL9IGgRgfgdDGsPhA7PuLSJRWF9HzRLAn7rgZyryJadY13sEfZN
         STNUANu1N2y0q2N5FlEuc0/NWWVyhwz5uuJnMZm8QKGl06IoA3p5VW/zVusoN29y4Vr8
         mo4gHYBDM6Q89bbL90VqZJ367Aj+OaMxjApK2YP8y28Z1yymUam2z+1yy95XbtNrIejO
         ChzIxxFechftu/U5U/wBDT0gVEP2oKlxwxnZ60hDmIh8CoIilAkFWUO68io3OwG8HaIf
         h+fMmPkDJIMBKuv9K1eKiHLTJXQRsJtL1xOOhtZtUC26DKRPRI+Qg8o83Un9LebCwswz
         uqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758052960; x=1758657760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDPBVUVtayrtvgwZw5aJFImyZz5WI+omxTmlAGFmthM=;
        b=aJ0qreJvSMbXGcx3a89D+xuGkYiaOUpB2FQTLbY2LCAw6sIM2qcnRrhUjQb6Wt07X7
         v2srBThTlIbYjLKutbFJL5pitrMGb8714mvmB9AiHD7ghkN/YHAUPXaO09Dj9GzV9xBI
         nB3Cc6hKKp2n1H2pb1kvIVZyRI3CLtj5aEEqEjiodUf5wowt+hw7OsKT/p0UeiqpwjUD
         Knyh/HubO0GPSYzNuIrJG3ZQkbMMRrZkn0SmlmEsFqlaICJyz23VsLfG70gUx5ilKDat
         qaDpkFMt21E1ya/VYOruIhW5ML5hSKQ4arcdanIkrVLRzam45OWTrXsuuhoFUQ4IfkI6
         U2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV6Hw19XIx3GIQ3cf9W/7dfmtjHEbKW0K+uTvMntldFuD57Agn5TQ/HbHVIw4uoMlze2PsZ+Nfg9yy6/ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrU/4aH9pp3SCIG38QuPnVRfAW6X7Mz51MzvpfbTrXGr1iKrN1
	8p7hJTbu3TXnGE8GI/NM7sXHy7cRSqVh1aWzkA/rnO6mzXdkjEozDiqBpv3n/wBk1sx5C5429sF
	ytr7guQ==
X-Google-Smtp-Source: AGHT+IHdkoO+jtZEzBO26MNHdXNyLDVSTI0DQhxv9z5DC0syuYZZVtivfQ02s4S5Te6oVnTkomW1LaOYVFU=
X-Received: from pjboh4.prod.google.com ([2002:a17:90b:3a44:b0:327:dc48:1406])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a0:b0:262:c083:bb38
 with SMTP id adf61e73a8af0-262c083bc6dmr15435648637.0.1758052959908; Tue, 16
 Sep 2025 13:02:39 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:02:38 -0700
In-Reply-To: <175798208800.624836.165612810420047605.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <00378f4c-ac64-459d-a990-6246a29c0ced@infradead.org>
 <20250905174736.260694-1-r772577952@gmail.com> <175798208800.624836.165612810420047605.b4-ty@google.com>
Message-ID: <aMnCXgLWN4xX6hjM@google.com>
Subject: Re: [PATCH v2] Documentation: KVM: Add reference specs for PIT and
 LAPIC ioctls
From: Sean Christopherson <seanjc@google.com>
To: rdunlap@infradead.org, Jiaming Zhang <r772577952@gmail.com>
Cc: corbet@lwn.net, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 15, 2025, Sean Christopherson wrote:
> On Sat, 06 Sep 2025 01:47:36 +0800, Jiaming Zhang wrote:
> > Thanks for your feedback! I have fixed the grammar and put the full URL on a single line.
> > 
> > Please let me know if any other changes are needed.
> > 
> > Thanks,
> > Jiaming Zhang
> > 
> > [...]
> 
> Applied to kvm-x86 misc, but only for the PIT documentation update.

...

> [1/1] Documentation: KVM: Add reference specs for PIT and LAPIC ioctls
>       https://github.com/kvm-x86/linux/commit/3f0bb03b9db7

I force pushed to fixup an unrelated commit, new hash:

      https://github.com/kvm-x86/linux/commit/5b5133e6a55b

