Return-Path: <linux-kernel+bounces-817949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D7CB58969
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6565B3AA970
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FCC1E8329;
	Tue, 16 Sep 2025 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TeSr3CRo"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623651A9F82
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982540; cv=none; b=oc7Z1F8m/jkgXyDyORpBUDlgqW2NYERGBFPYO8u9Uj56W9HavBhxZeuQ4VwUJjdu9RwtK5FguiyDi0lYDnpLuG/W/uY+8glN9gSsG84jTp0nsRclRQZban+wM7v5YNPv1QMK87HTcDVMJeWdxMbhYnUQlQF/3R55UAnQQXFIoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982540; c=relaxed/simple;
	bh=e75lMc0SwvaggAZg2pIkfUQvy0rB+lhmnzGFrVocssU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sPvFMUpvy4rr4rmV0QpKK1FkBsKxcl9OxhQfd5MHSPFwCH1sZc9Nr58UNT+5NmW578dGHnP3Z5fjnUY3ggfF0WMe+a60i2THgJmpnZX2W2y4Wf7mRyxmQDk3CLIFExjabDdgwBJqooR+zJl2MD4vUQ5TF0vbfSaV4BKm1rbupY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TeSr3CRo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-775f709b3ceso7092940b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757982539; x=1758587339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JekLyaH2vdbxnruvO3JL8OI3QMtUzMYV0BvO5yc4iYk=;
        b=TeSr3CRoh7eKDUb15wEJaw/zqJ1eyDXSRATWGjkPemU3bNx+s14zQ6H3MqoYz0GOi0
         PNog74aRBg5msfPPcwTzebD2SRj/aQ2c3bZaAwq5G5LGJ2d3Qd1+6OVHdC1ATbZ23cn3
         PxBtvEPkMGEGHOFQ+0HEKLpfTXwIXDVlzI5r5iFz5ywvivSqtmgOZ2OjqsgpKubB2F5w
         ShOrW/Muasaglc54OpYMZcLWl2z81xs36s9vdGJ3bj16htIKk2ho3qXTRnjkm1pF+9Qz
         bMqh5wnqDyaKb/we8OmVkaVvcuQj8nUnq9b0g5Vqzbrj3pHiURoEnZq5D6QATiYqz8o/
         uALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982539; x=1758587339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JekLyaH2vdbxnruvO3JL8OI3QMtUzMYV0BvO5yc4iYk=;
        b=IWOtbx3AgpgIsimI3uYEu+BISSWLGdWcmYW/foJX9SaQCtIRjCu4FlkpcLzsGomuhI
         uAybuqJ3XHY1BT1fOPV7dUsOrZxA6Rw6Y+KMAbh9w26RyWKl5zqpCrK9okX8gp2aCn6C
         GGDYZs0LjEIln+L2NOM4aPD+0Hp7H3FkbXwVrvkVEGEnW3hkl5hxUbxk+kx6lxNWZLYg
         TTHxRxUcZTETf1Odhhkwme/dak1keMLeavqNb/+8NBSpimtOG0OwC8a7OCm0wnko9CjM
         /znVqeif/HUV+j4l048vsDu81sMMvmqEVe/soHntoWdyHiLobmnt8cxXDhNrsUDf6xLb
         zoVQ==
X-Gm-Message-State: AOJu0Yzy64LXSfcTMUIhr7XasruRE37zjt8ooz2xZhZo9f6pm/Z4H8tr
	igNx1vpqVahgZ79WqBHh4F1kRn510F2UzgKvxprBzxA5N7QVhF8SJw1x/zHSsoAfnuGmEUvSisQ
	HaryFwA==
X-Google-Smtp-Source: AGHT+IGRIeH+RB2k6Y23F5nbG4AfDfA9gWbuk7l91FQSfotdHKdLc6ibS8/1jnXbtd+PYpwPpblaXAIJPbA=
X-Received: from pfbdc5.prod.google.com ([2002:a05:6a00:35c5:b0:771:ea87:e37d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2345:b0:776:20c2:d58b
 with SMTP id d2e1a72fcca58-77620c2d91amr14930351b3a.24.1757982538792; Mon, 15
 Sep 2025 17:28:58 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:51 -0700
In-Reply-To: <20250824181642.629297-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250824181642.629297-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <175798172387.621311.17652149879719315867.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Fix typo in hyperv cpuid test message
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, 24 Aug 2025 11:16:40 -0700, Alok Tiwari wrote:
> Fix a typo in hyperv_cpuid.c test assertion log:
> replace "our of supported range" -> "out of supported range".

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Fix typo in hyperv cpuid test message
      https://github.com/kvm-x86/linux/commit/665071186ce4

--
https://github.com/kvm-x86/linux/tree/next

