Return-Path: <linux-kernel+bounces-855026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E680BDFFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB1319A7A80
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23673009F4;
	Wed, 15 Oct 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cT5LTNf/"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EAE2550CD
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551536; cv=none; b=UBYrtnwBiZOnn33bN66RGGpA4ihpANejjwEsmsEqU36I4R9gQ38K6gEylZLr+tqrZH4nwIbImODe+a5Etcz6JSOxqCqKhUmQwYk71Uzu7fft4YVhIrtmSLTVeXfROyJubndc3oWDlsIOaQiADegaAd1CefIb0KHN9lXCTsaHXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551536; c=relaxed/simple;
	bh=UMsdyjzBO+xpQAtmVF2K42FHZE3eVQ96vmVxMXpt6JM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tyROQwKyeXjvMaEdDA1Lg+Dbn0wf1M4jaabySfBmIaqTun/1NRAz4odoWDbrCEPCHDmsIruO73vltMd0btanriUl69JjlGpHgbeX8j5GAyKvIVc4hUb/2Pv6UrLIDYz7xELgJlygvhWtEtpOsJmXjOmGgSZcHPKVUEd6VJtrteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cT5LTNf/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so10269290a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760551534; x=1761156334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yqvjk57rc7iKF+vXl7Uf8rmg/+Ppe3Al9zg0afoxasI=;
        b=cT5LTNf/2b6kYu/sXszHG+MgOK8685Bw0DC3pPiiGXMLJ12J6kol1tQkEFzidGOuYI
         NXubH1VTGLtaGjn7FrkmqGud30A8ke0mPczHxueW4vcm5OOc1lgEmniBHHuxuuGSc5zQ
         pU3D76vkTYlc9g4Z2PW60NZSZ9YBVKNXRUd53Sd46nZ5WXv3qLPHwCqgffrEecYZkfH+
         5ajdyobSwL5p4n8f9VLCoVKyWaTqE1WTM5uzjSlrV/xufcJ0f3XHUxDlxWY5Oa5RaHzG
         TMOwCQYxWM1oUfGPaOvSEC2tbVP19ggB5ito6G6A5dIMapiNoJah+1R7mODuafWee5lN
         XU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760551534; x=1761156334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yqvjk57rc7iKF+vXl7Uf8rmg/+Ppe3Al9zg0afoxasI=;
        b=jNyC9Ul2bsc+uPgf0Ayo8OCLK9xB9iDCQ3VljXmlK6ukeYtqtRoFpLl6AC1vrBZvB/
         YDLWUpzWID3gsuRBjoNLZRNGKxJr/3ek/UIp7lVarkpZGSwlmhT8y5SPznjWL/CjQlz2
         sDIhE2p+RHGlQ+sBtcXPqzpPzdxnLR9aQwUomApIxDRcariwUktJ/SZuYGsnUA/wGaWB
         NMypYdr9dIffJGRi8M4VTRsGblzXDlod7pRCGGqZAcQKwWZFX6Xi9GQnVAmQUsPkITFN
         rSZhk2fkeBuxv8wvJWN6LBh06Zw2fzJ0m6uSAVHWbHHBwdXcJsjhgUqbOE+nkKW0hfFx
         rnsg==
X-Forwarded-Encrypted: i=1; AJvYcCU4qah6SJ4K2js53vUv2xlIkRLjo9apTrPwVW1c1v+/ehqahsrL6QTENCI2u26Et8/AFqdcYIwv8IytZgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjiL08QsTaB2ALzwqCbjqFfz/m1xNazmy4RwOb9IA1I5zvR2Ky
	PoJvKFNuZ1HTormv3rOsUggvXGRMt0x+1ETWUqxmqu/D4Aoty7ew+CE1H6gunriVctU+6oPX1gr
	C9Wan3A==
X-Google-Smtp-Source: AGHT+IElZs0fBcFdjim1seSgDsyWxn2S91gbcqt//KzWmfvX3qRt8iq0IJ31IzrSDUiTdF9bCDDM8CcfROc=
X-Received: from pjbds16.prod.google.com ([2002:a17:90b:8d0:b0:32e:e4e6:ecfe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a91:b0:32e:2059:ee5a
 with SMTP id 98e67ed59e1d1-33b5114d52fmr43204782a91.8.1760551534243; Wed, 15
 Oct 2025 11:05:34 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:02:40 -0700
In-Reply-To: <20251004030210.49080-1-pedrodemargomes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251004030210.49080-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <176055116678.1528393.4651749265873372559.b4-ty@google.com>
Subject: Re: [PATCH] KVM: use folio_nr_pages() instead of shift operation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, 04 Oct 2025 00:02:10 -0300, Pedro Demarchi Gomes wrote:
> folio_nr_pages() is a faster helper function to get the number of pages when
> NR_PAGES_IN_LARGE_FOLIO is enabled.

Applied to kvm-x86 gmem, thanks!

[1/1] KVM: use folio_nr_pages() instead of shift operation
      https://github.com/kvm-x86/linux/commit/fa492ac7fb04

--
https://github.com/kvm-x86/linux/tree/next

