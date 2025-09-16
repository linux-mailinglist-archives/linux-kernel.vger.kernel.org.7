Return-Path: <linux-kernel+bounces-817946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7993B5895D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981C9521FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283FF20010A;
	Tue, 16 Sep 2025 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2wxwAB9/"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1D01F4C92
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982508; cv=none; b=KG0q0dzh2Jib92458npVAVWTDyFhuWe/MmFz+SYwAOlBvbwpxzzqEywj3m3UedwBUoeEjU/603DNuHiOri3iCq9YNeH3miHBq88MJX9gKrfSW+s180DZK8Vgf2a+u5MF/3QKQ1bjR7R+R9I1zP+3SfBGtSeQXVKElb1OY6D667I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982508; c=relaxed/simple;
	bh=Cl2toEc6CAoGA5jpfXxF5DiKy8azK27UiWOpHovroGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DUqznvwbEHzktLvaRdGz73uyncXm0Z4BoOrIp25Cn35YtcPAPqb6iPJg7mlqFSybKx+EAtWutEFZhGOMZtVj5JF6z5L9iTKc8GRc9UTXJX8OZvIRsA+a7V5vBn5h3G03xqo2vReNAuRDpMmtZ5u1XPsAJlESyTu322pwbtG8dXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2wxwAB9/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b52047b3f21so2621917a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757982506; x=1758587306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpg9eKfCbJSG199PCZYSezVp0AXOlN9Sq+ye6WlXKgI=;
        b=2wxwAB9/LASgQRxhhVz4LEdj8O9C0ekPRvZf6KFakzE+oM9paN5uWKvaQRF6WT+tjz
         jEMWxkRwg4VOa7evN83r2CrK6QI09G78yTKeca8D8ilLD85ERKdrSWHubHCIKsgm/DWx
         SQPvLz9p8Bby3Zr3nMQBvl1YO+ETnxfwlnZZIc9wWpctEqkKblUCLnsCghSLgOSQurLu
         jLz+jnjyPEjZyjjEMUOdUNsOOdA7wNvaiefiOQQBugIJVnvHfNBQYv5lHte9GsswmPaN
         meMyDca5YeZ93D7cQliI97c0vGnmN0Nad1tX2+VQNUz/9dLfkjMlZGPXLrzlbY2MojbO
         BIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982506; x=1758587306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpg9eKfCbJSG199PCZYSezVp0AXOlN9Sq+ye6WlXKgI=;
        b=uxzwfyEavi6VIeTcaautUvTdmkH7l0C52XiU5egDXmB1ombDxfl/ssJzPaV+FXISEA
         PGVBzqKWGS/ehiLm1pJeoc5YjnKZFWRayAmtqiQ28Uat7B4CvzZVe4aQSTQdS8ZqIU6V
         7BQmBDoWS/OK1xMO4GIj0uEJ8PKWQJlEGF66uhX4BLzsdcE0iCKahHl/ULIdTVPEunyL
         6FcBW89/JPXUlDzSkDh7EaKEGoHEXIe6DzfPyWfhfJLW2WYwB2kGVLJZBWKc81o92AAr
         FdNYrslxE2oVk1fuvbyoItX6ra2ZchZNPLRaHmLn8lXwa2pl2vwvVByk1HROw4AHizwZ
         rOAw==
X-Gm-Message-State: AOJu0YwxCjZmFjDX8Wc+X6wlOZSOQ/Dcqf3x10sx1j8pXN6lvI0E07Oa
	YPSD0Z8iUUvHqw6KRhTqs/oAcZfWiAqjOfEY9BZ/jr1k+dhcLWvhGQl7PyhGSBRa7zs0UUS+0b2
	rXsNWDw==
X-Google-Smtp-Source: AGHT+IFwN6F1IKyi26MfH4OV7wrQj455Uiod6EJO3drqvb6Io600y9Hw+xiMvYZUDmZD2RI+VowdCbnCrcs=
X-Received: from pgbdp11.prod.google.com ([2002:a05:6a02:f0b:b0:b4f:a4df:5cb7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d83:b0:263:9d85:3733
 with SMTP id adf61e73a8af0-2639d85384cmr8646741637.31.1757982506554; Mon, 15
 Sep 2025 17:28:26 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:45 -0700
In-Reply-To: <20250827011726.2451115-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827011726.2451115-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <175798193779.623026.2646711972824495792.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: TDX: Force split irqchip for TDX at irqchip
 creation time
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Sagi Shahar <sagis@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 26 Aug 2025 18:17:26 -0700, Sagi Shahar wrote:
> TDX module protects the EOI-bitmap which prevents the use of in-kernel
> I/O APIC. See more details in the original patch [1]
> 
> The current implementation already enforces the use of split irqchip for
> TDX but it does so at the vCPU creation time which is generally to late
> to fallback to split irqchip.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: TDX: Force split irqchip for TDX at irqchip creation time
      https://github.com/kvm-x86/linux/commit/2569c8c5767b

--
https://github.com/kvm-x86/linux/tree/next

