Return-Path: <linux-kernel+bounces-825218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570C8B8B4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D563BA79A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4502D3EC5;
	Fri, 19 Sep 2025 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5N+wFrq"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A762D3733
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316549; cv=none; b=MUH9Gf6Y5PmgRxXWYHCUAQfXTtMfLXlKraVnMCZlPqv1tPX9YZXFG4DhHeygVHQcJ6Mfw3cZ0HXpIM0T8s+lnAdfNCqE0x+BtULo0cvY3pRmuHP17lEzLOb4f1KYyZFF3XTDeZ2g5rYO4WV/WZ0LKmBLRqiVRTVAx/Z56R3D88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316549; c=relaxed/simple;
	bh=75+xMcEBZ4CCJG3zy2Fp8An358EsjOFKAwpWo1duVAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NxVeVpurf/s4Sv0JIbLR5iek3jh0/OxUNZOUAJpqmwfcegV5DGet3TQzPJxT9tJkgkkBkTDhACSlm7LlPUXLB9R1B3OTW69HX+05DjR1vB4u3ZzvGCthjHzrI5e9uylVl5thIc3/pgmDYFroDVDIr9EBgHmswmMejwFujOgY/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5N+wFrq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-252afdfafe1so26915705ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758316547; x=1758921347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0+Liys18anQK6gRZATENTJbkZzHDkR1/8jEpmQV1kk=;
        b=V5N+wFrq6fqFRTC7AmC26PUcdxAZ8h9bG+e3cZ21ID4LzXmZfij2HTgMAGmOQc0rhC
         Ar+nVd4C5vdVvBX72hAvTyoBACMM7MjTNYUolzviG/e2E+cHlIs2iJRiOgbDCcAm+D40
         P3mwCkKBKS9IFUW464zmiarb5QrJEBcvN30aMgL6X6BrzFv5S6EBDZgzR82f7zKZ2tid
         RSO7h4XwwMRP4h+uHWA0QyXvtc+liL3LDpwl1GAJtCG+TNIrt8RES0FkSsoqRCSNhQdR
         Tpz6uTgQv6uN1VO0eqx7vpZDygwXapnfhuT+cMKG3L0mZ/GKZstsZUAmo/PzpS+drzah
         HTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758316547; x=1758921347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0+Liys18anQK6gRZATENTJbkZzHDkR1/8jEpmQV1kk=;
        b=ZDvccz9RsZDkLnl7P1rxwmiLNPg6shWl+Y0PVudGvsaNm6eDvPk8yJb8lnAFIwepMj
         ZslXLE/MwA0Uis0P29wrrLXxJbCoBALrxyUH2VZEwKtDNetoXz4aDHey3jz8PYQYR3fS
         l4WIBWaqYLSKYjzrMF5WdlxtKBbSoAhr5c9BYH99OQvgFPTg05MUeJ1bU0PoRbZfCX/P
         nwhX5Jkbv0KXiuKWLK+pPw+GicotvQjc/FLatbQ3PEvDmRkJNshNfoaZSi0jiiOo9p0Y
         /w3f0v4vAYbphUoCq1B9AZFSE1B/fv4SGZK5p3emwInTrqPmCnGZWSl9lva2sYNiuNab
         fQBw==
X-Forwarded-Encrypted: i=1; AJvYcCXoX49AM2oDNqH+OqwBOagAx8HoF2AgiiyhZm/t5vACjPjiIdk+ljuXl2uEl5noYVTCixx1UXUiCUiaKmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxLZBpSMUJVeLQpsfpgmb7k75zRRSXXyCTXQgzRuo5hOZ0kocq
	7aL9paGaUkVIn9GgJm7A8JT3BNWNuqZtAo1dB8yP06EEHfzHgSdjhq1udItFkgnwlC8WKfTyzty
	CGHApjA==
X-Google-Smtp-Source: AGHT+IFdtQnkscwGqsgriF6C5QkossH14ZthE8OI9NmQ2k9LQwcIhxPc2sZV4JW/RFjatX5u3z54HnLVEKs=
X-Received: from plbjh12.prod.google.com ([2002:a17:903:328c:b0:269:96fe:32ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac2:b0:25c:e895:6a75
 with SMTP id d9443c01a7336-269ba4f020amr59534475ad.28.1758316546890; Fri, 19
 Sep 2025 14:15:46 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:15:45 -0700
In-Reply-To: <20250918181144.Ygo8BZ-R@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org> <20250918154826.oUc0cW0Y@linutronix.de>
 <20250918120607-mutt-send-email-mst@kernel.org> <20250918181144.Ygo8BZ-R@linutronix.de>
Message-ID: <aM3IAaCVx-PDeDsi@google.com>
Subject: Re: [PATCH] vhost: Take a reference on the task that is reference in
 struct vhost_task.
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> vhost_task_create() creates a task and keeps a reference to its
> task_struct. That task may exit early via a signal and its task_struct
> will be released.
> A pending vhost_task_wake() will then attempt to wake the task and
> access a task_struct which is no longer there.
> 
> Acquire a reference on the task_struct while creating the thread and
> release the reference while the struct vhost_task itself is removed.
> If the task exits early due to a signal, then the vhost_task_wake() will
> still access a valid task_struct. The wake is safe and will be skipped
> in this case.
> 
> Fixes: f9010dbdce911 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> Reported-by: Sean Christopherson <seanjc@google.com>
> Closes: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com/
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Tested-by: Sean Christopherson <seanjc@google.com>

