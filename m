Return-Path: <linux-kernel+bounces-894392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85292C49FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7CC3A5251
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4B256C6D;
	Tue, 11 Nov 2025 00:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlceSfJl"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7941DF258
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822360; cv=none; b=BuUrWv7gK66B/QWOt8ZG2LXpvdMw6Vlw4Z8JPv+2fM6dLZh582xcDZgEQHffKzkX2V7ji0+VHTjygy1FkphEDK4ZwuwPUqCX4Jm5v/3Cgcg92sTl+0Bscpwom6QOpdMq1J9GwrrrOjwySBdgRyUIhp2G6QUgnQHQybDHRi6cyao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822360; c=relaxed/simple;
	bh=AtQ/82EtmVgp8qVHviU2+lHSIDSfcaSM+ddQXov0DvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xjyf1YrrrvpuOQjAYkhYkmINoYvj7MDGc0q9umA9lr+FVoZ9JmWnEWgFGsmIEAOU7zKpnVe7KE1/8qb+AqmOV4LUJQnCyGdA8CF386h8X+Nd36C4pyAM7lB1ygpQrzfciTg4axNNNZrkA9Bq5Eh2Fm25BLlQQl7ppOpcZxr7+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jlceSfJl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295fbc7d4abso35182095ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762822359; x=1763427159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AtQ/82EtmVgp8qVHviU2+lHSIDSfcaSM+ddQXov0DvY=;
        b=jlceSfJl4F2T36U7vbWdfXsJINaGGkySsbU9ohLSrmdSdZeHBa1X+gGfddID9o6Psj
         XpmgyHGGBbGTh71WEIA5Gs+Cbwd4xKRAg7mbEdrboka6ubt9q59QmQ/nT4TbJfjHMCGU
         3nWwoSzuT5k1XyDechZuamoQfx5mO5ch93kSRI1lXrz0qhJPrps6+G7Gp1agQG7KoDdE
         /7+qfUWH6yz2lTBUWqHd8ZjRDz1DgneGG1HOSgwwNgqwtvIXpHqJsLPV0ze7SGWEHO3m
         Wo69rJjycG8H8RmZufzX9E4+xr29rsneUxk/mgfpCfAZ6kQN4ST/LjFDQXSUxcy2GYiT
         JrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762822359; x=1763427159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtQ/82EtmVgp8qVHviU2+lHSIDSfcaSM+ddQXov0DvY=;
        b=wLun8qvjLawR6jqTvAx8xM94Es/4+7c7xeQeHQi9rwJSnk1OrSN8+9V0W+YMTZoqHo
         uGthp+kJZCqB4xFAWB6NRrwDOAojaYA29efiNWFGC1tRJsRhxZ8sZFl+GuzLsg1tEEqS
         WaasYY1urhuIU9rOdwGd719Mz9ZDvNiKiLeGF562o4vmoddFJIEpoG/2Lj+i7IAiwcX+
         L0j/v80dP7RpVz4XB9P5/PMrfZyYI79lfDlHx2zXlUN7ZscEbb69Xdqi1wEDYk8+8FyQ
         g3cp7nynuDtvptK/s/wSpOIoKeY0OT85OwwsPdhkrXikBAC61MWjoO96BRUj7PY1JHEE
         seKA==
X-Forwarded-Encrypted: i=1; AJvYcCXwYBgWuyud6YMBgu5b/J+MFFcx0u9II2H2tvgLHO2tUIQC/PPXizgu1fadj/PHX6QBrbqBkRbbEveF3Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFuXaTqba6gVCVu3gU4tBR+efW+sx3kUSSP8ZgrWX+4yvAFQuY
	Byt5InccBveEcqjflrAhDLnGA/txg/hQ42QIm3D2nINrHwHx4heC2G8l+maYLyNtVsCUGZ16TvZ
	VCkb8Lw==
X-Google-Smtp-Source: AGHT+IEbjrsxaiNUslg2isBtzSL5dpA3I7qFnMuYN9dPxztymlV3kqChz46KobwAd71NGTPeJlxs97sSep0=
X-Received: from plnx8.prod.google.com ([2002:a17:902:8208:b0:295:5d05:b2b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aaf:b0:298:3aa6:c03d
 with SMTP id d9443c01a7336-2983aa6c179mr35537105ad.57.1762822358616; Mon, 10
 Nov 2025 16:52:38 -0800 (PST)
Date: Mon, 10 Nov 2025 16:52:37 -0800
In-Reply-To: <20251110232642.633672-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110232642.633672-1-yosry.ahmed@linux.dev>
Message-ID: <aRKI1bzrNRiWaQBK@google.com>
Subject: Re: [PATCH v3 00/14] Improvements for (nested) SVM testing
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Cheng <chengkev@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

Nit, in the future, please label the patches with "kvm-unit-tests" so that it's
super obvious what they're for, e.g. [kvm-unit-tests PATCH ...].

