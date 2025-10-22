Return-Path: <linux-kernel+bounces-865535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D76D9BFD54B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B0519C207A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C83F26E709;
	Wed, 22 Oct 2025 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8TNOZFv"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D762C0282
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151091; cv=none; b=ntAX0yoOMGLDBXkmY9luC+SzTxlSpIn69ZFzCzB5fXEm7NfcBnKtbxknpzKvGY+jQmvVGfGCDT9HmiZbE6ldzoOfZoDe3QlMYX7tEFaSN3boAb3m4iHaz0yZTWc91LsLMfb1RV/V365i8pMm9/0iEhP3oy/FrBr54URH+C8U0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151091; c=relaxed/simple;
	bh=+hpV4vedpfetjV9Sb+SG47OMjYDV8jGDb2DbIwvD3/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9x/heGemrCesuaLeMlxIrcYF7G/5JM2u2OCF6Lvj241r4JVaT22Nu1+3SFIIT7tVHuer02I8WYh5nz1OqHti6detJhVNvXGQYJ3m8u8oo94JeLu+O15sQP4vBDUe4p+VC4xOKUiXb/qqSQCQ4jdqTj4hhh9biD+28+e6xSI5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8TNOZFv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-421851bca51so5880743f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761151086; x=1761755886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dk/4ZoqQnuZjGsM9q5wggvWU1iFzfw9iqDvZDTlZi+Q=;
        b=f8TNOZFv7zpkrZPVE5rkN7DQGoHCxk9tILa5PqkXjfxgMAQkQVcVdxVcdI17DtKzYi
         dBrN4R8UMNfRXFhMtU12WZAHaZPG+piQ4PORD2e8df1CJEff5V1nMheP1UrCqsdMNw5E
         l1DssKV1pSDIAUfEC998POJos+fk4BCQbhRpqeGQJCOtMFt/8rRmep9CVOM5l2WknteI
         ea54vhJEwMQx/gDx83H53za4wM4yrDUUeNEYq97OJU7g3dM7v5zUFf+H+18uvLlNk5rB
         ojFiPGDv2NQBw70IHbABvSQMEKsM8TvyfrNZNaOWTfmnqvJ4o1xWmOiQ9xQTRUCvnCpy
         FKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151086; x=1761755886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dk/4ZoqQnuZjGsM9q5wggvWU1iFzfw9iqDvZDTlZi+Q=;
        b=IlF/1aRMNE3Eq2vMl1yBFXGV1TFMklmWbdWDJYJ+/NV8DmJEafDUqgk9rdOD+QJHCN
         hy0KGLym2xqkxvyrTwMxZAeWXPR+mHnfZxAQpg/01dul8jXznICrGpka4rxtdpyuUMQH
         n1mH4tVFZwWTjxA3KbGbGnI7n2pVKHudWpEkZNnoQDcR76LdovCwSXhbIyUeRnDs7+Sr
         g6jK22YOxP5atjVG1ZpEIAsCiJvuBCIrItF/7uyMjDOUoZxibDhY0ZYJ9xRY14T2g8s1
         AyK1Xn9djsnQAvCxNy8lQUOwpJuYV8v/aT8SyUvzeWpQxtur8kPawB1QviuMYNXLtzdj
         Sjqg==
X-Forwarded-Encrypted: i=1; AJvYcCWUUtw2jYaZuBiX9aJqNRNL0vOn3FTHceXGOixGOq9GQBDD18lNpUwjONz8zKig65UfVBuBJO7vuSwa0IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8fhPurj8mF708lz6TPpgMm95yKoJz+GLu80Ok52n3aL2iVs4
	gmFI1glnvpJF7DYdsPbDeMY7Uac5S5M5f9UXGz3rQBH6QlDtxCNgfigr
X-Gm-Gg: ASbGncu07iaBDo3lXd5HvwsUAqEOwQFCo54VnElzOjXRIRh3rGIJ2+OY9glZFv8U/9p
	OproG2W8vKzdhpZn3fecyGF9hJ6/qRMUW5VNymEcLJPQU+otXZLXBtGH2AQTww9iIyZ0H+Gbmj4
	dFxjjFhv1JfmgSmUzalrwthYkVO4YpZOPzE5siSwAa6SvpOGXPPy3VcTRBUrCBD3i5jD4qmPXsD
	h3oqVoN25aIJ2KqC3H00qJwiRy9mWrPbAbzn21Mm0BOsY39Gtw+CTJ7fRAgtpIzt7b1jvzOPYF4
	igNIRitzXsJiuDOb9rLaWDV6Uw0AoPvfIOrRpzjONoVc4APEZeWVLbWwF7JKbKl4Z5f2KWvLkXD
	anZCLD9BYKuk0ptAcnqw4K7LtnAIg3NZQoySR4JU0XwhQmGXAnDDlTfA55y8IpVQKefmyAIrMnY
	16JZsvZ7gRxDy8e9X2g2bWc6DZIwnLKFuQQXv6A1PySw==
X-Google-Smtp-Source: AGHT+IHnj3ehGxJN2+JHKpPdZQwBjMorNnDAsuy0gAmpVUMFwxWZqRD/ApfaITrwLRrw0TIRv+66RA==
X-Received: by 2002:a5d:5850:0:b0:428:3ee0:6959 with SMTP id ffacd0b85a97d-4283ee06d92mr10911700f8f.63.1761151086240;
        Wed, 22 Oct 2025 09:38:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a78csm26028279f8f.26.2025.10.22.09.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:38:06 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:38:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ryan Neph <ryanneph@google.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/xe/configfs: fix clang warnings for missing
 parameter name
Message-ID: <20251022173804.26af8d39@pumpkin>
In-Reply-To: <20251021063957.GA757076@ax162>
References: <20251017-rn-cfi-v1-0-bf66e6ad4fcd@google.com>
	<20251017-rn-cfi-v1-2-bf66e6ad4fcd@google.com>
	<20251020110513.48d18788@pumpkin>
	<20251021063957.GA757076@ax162>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 08:39:57 +0200
Nathan Chancellor <nathan@kernel.org> wrote:

> On Mon, Oct 20, 2025 at 11:05:13AM +0100, David Laight wrote:
> > On Fri, 17 Oct 2025 12:46:26 -0700
> > Ryan Neph <ryanneph@google.com> wrote:
> >   
> > > Fixes warning from clang-17 that look like:
> > > 
> > > drivers/gpu/drm/xe/xe_configfs.h:35:97: error: omitting the parameter name in a function definition is a C2x extension [-Werror,-Wc2x-extensions]
> > >    35 | static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,  
> > 
> > Why did that become invalid?
> > It has pretty much always been used - and can be used to avoid -Wshadow warnings.
> > This looks like a clang bug.
> > And you'd want a specific -W 'knob' for it as well.
> > 
> > At a guess the C2x extension lets the name be omitted in the function body for
> > an unused parameter (the same as C++).
> > I think that is the 'definition' and the ones being changed here are the 'declaration'.
> > But I might be wrong.  
> 
> I don't think you read the patch clearly enough. Both declarations and
> 'static inline' definitions are being updated in this patch, likely for
> consistency rather than necessity (but the commit message could call
> this out). I don't see how there is a clang bug here.

Ah, I only looked closely at the declaration, thought the second change was the
same.

	David

> 
> > > 
> > > Signed-off-by: Ryan Neph <ryanneph@google.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_configfs.h | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_configfs.h b/drivers/gpu/drm/xe/xe_configfs.h
> > > index fed57be0b90e146d57d966bab0e55e1723513997..a0d614b37efd54b89390f04a238aef1a8d4df4e2 100644
> > > --- a/drivers/gpu/drm/xe/xe_configfs.h
> > > +++ b/drivers/gpu/drm/xe/xe_configfs.h
> > > @@ -21,9 +21,9 @@ bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev);
> > >  bool xe_configfs_media_gt_allowed(struct pci_dev *pdev);
> > >  u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev);
> > >  bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev);
> > > -u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class,
> > > +u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class class,
> > >  				       const u32 **cs);
> > > -u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,
> > > +u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class class,
> > >  					const u32 **cs);
> > >  #ifdef CONFIG_PCI_IOV
> > >  unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev);
> > > @@ -37,9 +37,11 @@ static inline bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev) { return
> > >  static inline bool xe_configfs_media_gt_allowed(struct pci_dev *pdev) { return true; }
> > >  static inline u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev) { return U64_MAX; }
> > >  static inline bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev) { return false; }
> > > -static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class,
> > > +static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev,
> > > +						     enum xe_engine_class class,
> > >  						     const u32 **cs) { return 0; }
> > > -static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,
> > > +static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
> > > +						      enum xe_engine_class class,
> > >  						      const u32 **cs) { return 0; }
> > >  static inline unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev) { return UINT_MAX; }
> > >  #endif
> > >   
> >   


