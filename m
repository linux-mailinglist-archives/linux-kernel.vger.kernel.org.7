Return-Path: <linux-kernel+bounces-862900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9EABF67B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E517035396C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678DB32ED21;
	Tue, 21 Oct 2025 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLy1KFH0"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3363632E741
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050336; cv=none; b=IpY16VA6fXhJ74STvjAnf/omkm0qRLqlWE0mwgTYAQYzk5jRccYGoQhDW72i4rAAlvQhC2RIpprCPs9I2JIvRXtTkg4IyGW4Sjj6EI/+uWROTg/lORLlw6eJ838Vq0gSXImZFNZpa9V+bm4XtazHA44bqGDz8Lf+4xr/tj6ew1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050336; c=relaxed/simple;
	bh=mHDkxZIgV1WlRJbMtp+HutFhcDGsU2i3APvf9PfVJzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2JoJXLs/3zpUmFJ6KFkUmfNNhAbSJQVEp5/jhAdei17ZnlJ5FEjwq5CEzk47yXiLjWswhkZ+gD1uxTspJmaCX62dImqLAXUEffoXGQfjbeuIns4Fj2Y0Bo9eYdUKEnZoYUKLLiciHHivAABv9lIWyyy6g0w76KMrAadD0ikKDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLy1KFH0; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7810289cd4bso5258969b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761050334; x=1761655134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nouOVrwQ50AtkUiwuvOBNTOWEJPD1kyilpHzlZVLbTA=;
        b=hLy1KFH0orXV0mUdn2nvl5ogcLgJTYxOORH0DnfMX0kIQhraGGs9GnHQ91Hv4fyLBu
         CeUug0bb0OHWKV95Ce5Gjv4/3+9QFAPQ9WIY5PVpbqrDHzQnqNzPrLqVT7zHuwxPpu5/
         6GNiVmXfMLJdGSaGGHxAXbQOBX8+BaKEfjgWKqc/3fAQdEFs5q2CPQXt503uU2Ajj0Oj
         SU/Od+lul81/YyY5t5a7X79wRjgylqiUU3qBGtqAuZ0Rf7WUZ0QJn8P73+RGSZuL3lB/
         zNIOajCHdjEYdqr4n5YUvnzA2ztT/cCuXIVljGXSrkm76OO3skI/xipzMiOIQJzzaByW
         bzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761050334; x=1761655134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nouOVrwQ50AtkUiwuvOBNTOWEJPD1kyilpHzlZVLbTA=;
        b=LXQPx5ejaiYrRHlwiXGvPcGBeT9RujG7lTSYOFx9EgskHNEH5UqlFuOqxv9o6yVFIq
         zObwr0HIT21xO9dFUtFnOF7MKtqTaWqfGe2LEZTLuw9foBOmKCbV4t0+ZaSZ1re9ZqFx
         WBFe4qtJFlfIIoX5q7Js1vWPGib3WpRqG6cvIFuCamuC/qvE87an89DJIhI4hZRgXAAK
         G1W+jSZtIKllGFdkusEBXkJ2Hsop1cnkrLWcKMnb86k0kbVp1JSJlbf92h8nBLMCMNvp
         /6YEFzrHDKPOkrkk7rIxzg3cOCyXdgUXhXyGrskDiLAB9u7USm6PEcD7Pek0Q/prFPQP
         NQhA==
X-Gm-Message-State: AOJu0Yw9TdPsuxXFSE7Za9FxM+AKsNly2w5n0Q4bgvfm+jw7W7L8wQd2
	wn96MlSgmGeE90mRpY3e6amd0mZZ1YtyRElomtBt0HJ7yAyBFqAAQ1Qk
X-Gm-Gg: ASbGncsy2N3WFF8WLY3a8u32zpAw/oZOk1j8/hPlZlT09ss6tnxvY4qzpfOBgDvA7AQ
	LbKH0gkAZHWC4VMGLx9cFx5gCceI9kJ0BEdbPUSWCnhzcZcsiA7OmTO8dKNdfrcWDhWbbVKIY0Y
	ytWVWKod0MALLbcG2v1t6Aqc00Eay3YwYj3OZBP80DLX6nmgfkZ01CK+em4lygVAG8fdQTdGw4H
	MNLBDCfnXDDiGW5zbrx6o04l/ivG/oa52dJ7tTIka/PiQsE83dv++CxNjdrzAxAvh0aLcdSgReb
	cVq8zfWgfsWrgapzv4qpPjXVc6Vo/J6R5mipcDrGLH0xtuOjY2VrCtjwTGtsq2ELJ34Dy5Teui3
	gZzGbgn2Hmg/Rs48Y3WNvF7VB4shXD3OtXQdzq7L5buKP394XyxR6Jra0xY0m8uBJLM0RU7vioj
	/XAGaaSnZYXRYYl7bGOupqkcSwxiQTF6fTwVlFkvc=
X-Google-Smtp-Source: AGHT+IFwl7RUH1by8AgGc+oNOKvpnFXUyqZAom8I7koI3NV7bibbAKhuB2xsuiXOSaExjXPs0nuRqg==
X-Received: by 2002:a05:6a00:c94:b0:781:2ba:ef21 with SMTP id d2e1a72fcca58-7a220b1d061mr17172564b3a.23.1761050334408;
        Tue, 21 Oct 2025 05:38:54 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff35a59sm11169428b3a.25.2025.10.21.05.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:38:54 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH v3 1/2] selinux: Make avc cache slot size configurable during boot
Date: Tue, 21 Oct 2025 20:38:38 +0800
Message-ID: <20251021123842.968605-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHC9VhQ_hv1ri1csrgGP+9RssCuJBDuOLSDowZRD5xZcDD2mPA@mail.gmail.com>
References: <CAHC9VhQ_hv1ri1csrgGP+9RssCuJBDuOLSDowZRD5xZcDD2mPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> I would imagine that a very simple implementation would simply convert
> the selinux_avc variable from an instance of selinux_avc to a RCU
> protected selinux_avc pointer.  As the AVC already uses RCU, I think
> the number of changes should be relatively minimal:
> 
> * Ensure we wrap selinux_avc derefs with rcu_dereference().  This
> should be the only real change needed for lookups and insertions as
> every search through the AVC will start with deref'ing the selinux_avc
> pointer.
> 
> * Update avc_init() to allocate the cache slots with a default value,
> fail if unable to allocate the cache memory.  If we ensure that the
> selinux_avc pointer will always be valid, we can avoid having to check
> it.
> 
> * Policy (re)loads which would change the number of AVC cache slots
> would allocate and initialize a new selinux_avc then swap the global
> selinux_avc pointer under spinlock.  The old AVC cache could then be
> free'd according to RCU rules.  I haven't thought about it too much,
> but I suspect we could do away with flushing the old AVC in these
> cases, even if we can't, flushing the old AVC is easy enough.
> 
> > When increasing slot size, we could directly copy the contents from the
> > old table. When decreasing slot size, nodes exceeding the new slot size
> > would need to be re-hashed and attached to appropriate positions.
> 
> Changing the number of cache slots should happen infrequently enough
> that I see no need to migrate the old entries to the new cache
> instance.  It's a cache, it will fill back up naturally.
> 
> > On my Android device, policies are fixed before system image release and
> > don't change or load dynamically during system running. Using kernel
> > parameters for adjustment ensures no additional locks or checks are neede=
> d
> > during runtime table access, maintaining simplicity and efficiency of the
> > lookup code.
> 
> If your system does not update its policy over the course of a single
> boot, and presumably doesn't drastically change its behavior during
> that time, there is another, simpler option that we should consider:
> setting AVC_CACHE_SLOTS at compile time based on a Kconfig tunable.
> The code change would essentially be one line:
> 
>  #define AVC_CACHE_SLOTS   (2 << CONFIG_SECURITY_SELINUX_AVC_HASH_BITS)
> 
> ... with a corresponding entry in security/selinux/Kconfig.  That
> should be a very easy change, and if you set the default value such
> that AVC_CACHE_SLOTS remains at 512, there should be no impact on
> existing systems.
> 

Alright，I will add a CONFIG_SECURITY_SELINUX_AVC_HASH_BITS in
security/selinux/Kconfig, the range is between 9 and 14 (512 : 16384),
with a default value of 9. And then I will send a new patchset version.

I will try to submit the final version in Q1 2026 based on the discussion
(Because I have some planned Q4 work that hasn't been completed yet).

