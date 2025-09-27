Return-Path: <linux-kernel+bounces-834821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CB9BA5984
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB151C04EA6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76708257848;
	Sat, 27 Sep 2025 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYB4W/yB"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F9224AE8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953353; cv=none; b=JSD+1nejb1nlMBgHn7WoIgv2EJxCHyoJY2mMwigYlYxxGAMBEdbw3rY5JUUVkLulNX+eB0WmKb6MFWsawc3xX55cnsrWnHNB1kee+yZWFxbmWLm/GXRmhKwwsRTXBIRWec92HAsS38x4SM+iz/WP6OKfHSxl4UlUDj7Yud4cBzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953353; c=relaxed/simple;
	bh=i5zg4+8PUYuhCtP9C0+puXOxNIsz6uy6KOhZFdGIY0E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KtswM9K721Sx54M62qL38rmJEmQ4jPkN81y7C1rC4nlCHoeRiwOQw0V02MPL6YW9ANIkT9E8uNjFjqi46ZwHY3PvPunrrfb7Lejx36acnIqIrkAE57+3sz029Vsw67Jx69VD8g66GKs7s3XMF62d+V5nINyK59jH+H0FTLmdddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYB4W/yB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so2017565a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758953352; x=1759558152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92jQdJuxQdR6avb7iv3Qbc3f/OOpWrDHJMr6ZqVAL8o=;
        b=SYB4W/yBiRnnxT2es5BXpTxrnVgDgLxCIyPvBrvkPJY5OdAoUU2KJ49GZW4XcSKcSN
         6pa7qP63bTv7DUdPLhovDFWR/qpP6NGdqONkDYJqLQYhCM9Fam+UoJy84KEaxDyEc2pc
         hDmSZmer9pzZoRLmuKN6dFoQboCuFMejvdVMA3OCIgkoS6vJupFPZXM42Io3XdbsIuDW
         IwsszueGNmCtR/hCcAwBlrdiSEnDkSpiJOgmawZRs/wBHCzL3GafZvzMjrp8pqMD9w9J
         iljdn/8nmBzeoAdXdMe42MtQawjVE1VU+/viBuRT8tLYdm44w5u+MbWUiQ1zmCr6pULd
         fheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953352; x=1759558152;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92jQdJuxQdR6avb7iv3Qbc3f/OOpWrDHJMr6ZqVAL8o=;
        b=RB6qlXrl5bNVvDAEeXbMKevd3V8OnUV2W0x2XQdImm1/Uf/muEiOvXAISjVJkJCwca
         QOTMoXDLuw1/Abv0iNTvHGrxpEnpd9CTX4yXDw2J8VZV3jmTdxxvomXdg32v9w+9Hn51
         CDRXxwrDcRqyyAT1q0ZbYDE6k+GyeP0LXHIK2+n1cSdrKxf6jnr52Qo7ZyVTnT6SkRZ1
         EOsh6BNGWuUo7i0pcXb2MWO5RJ8SIwe7UWiVRm3rGZIu0Jv7KORrho/d3JUeQPKwW7J/
         +bNRzwa97C5h77iupo/sbGwhy6F3cRbk5ZPrFdoq9J+YHXmljkfohYTvQzoDSLvvvlor
         XUlw==
X-Forwarded-Encrypted: i=1; AJvYcCWVa8vyBQ3eRpCYrGxzxF4Y6swdEQLHZ4NfDYES3Dr6yhSHIOPUB3niqntMOtUxfVxQjkWayxHt3BcUhqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXXqKu/BkVo/6TA5uf4I2/miB+4zjdLq1kuUYkl4pX7g5vH56
	3isavtDvlZ3wHulIDEuJ8yPWRc2doG0+T49P2/V4QY9tUJMJdNPjPCAgfxCGQ/QzsiizLaBsiMf
	Lv1VDoA==
X-Google-Smtp-Source: AGHT+IHU6zbrUaVmakUk3kyedknL296gdxZuhglgjKuQKfKwMYOtPpoHQeUQfd/oDKLJtqNSbMf18deX29s=
X-Received: from pjse3.prod.google.com ([2002:a17:90a:77c3:b0:32d:e4c6:7410])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d19:b0:262:22ff:f018
 with SMTP id adf61e73a8af0-2e7c593529cmr12001947637.26.1758953351821; Fri, 26
 Sep 2025 23:09:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Sep 2025 23:09:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927060910.2933942-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86 pull requests 6.18
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Sorry this is coming in late, it's been a long week.

Similar to 6.17, a few anomolies in the form of external and cross-branch
dependencies, but thankfully only one conflict that I know of (details in
CET pull request).  Oh, and one "big" anomoly: there's a pull request for
guest-side x86/kvm changes (but it's small, hence the quotes).

I tried my best to document anything unusual in the individual pull requests,
so hopefully nothing is too surprising.

