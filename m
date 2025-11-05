Return-Path: <linux-kernel+bounces-885677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20568C33A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D317C4E6F67
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC524A04A;
	Wed,  5 Nov 2025 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FK9N7yKW"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219723C512
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306112; cv=none; b=amRt53ZOkGvWQJtyIdJyoeQWvf9WVpkikPqvxlfDEdLixf/c15Og5edkzQx6UGsc99AYVPi+IYrcyKQQLcQNIeebvJX3UOwRrj6BtY5IyRMWOcoszMC/1g1vIWdborFD0k/aCfwDYRzqFb582N1dCkK2Zb1pZBrlPHltupyo9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306112; c=relaxed/simple;
	bh=qNZOUx3FAp7TY7xgqzRZ+MDKI+Wh0Fr+MDjZGtR8ru8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r52lTB4JXN53dLzvrwdBVw98/VwaCsuA0IhP3myk14Y911+fxIXRnG+bhCC1H56BDZ+HWf7Y73HHuLn8Wp+mvWCjS+N2ZxS96oif4UOl++eG30hX5Ce/UTDuAVkIVaG6HNFoA7rXHbaK1TrEWQf9DobONEcVbeVsMRxtHHKE9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FK9N7yKW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781206cce18so374813b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762306109; x=1762910909; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPPUewGB6So9V+6so9jHVW4+5E6VBrMKCWD6USZE7ko=;
        b=FK9N7yKWZ0c+TzCxOWPh7MWt/B9AnBRt0g/uNLeWSMKzJy1PvNHEZ71ngKTJdT1ZUJ
         pPQE83OdfoV+rmX1MsHmtWpHD9RxjtGyvl9UqYpLdgByr3A/6bYhoK01XxF6JgaKzysu
         5QzrkmDW0lG7LGXAcM771Iv2OxETtZb/1C/n8u7wU4FeEhMAU7G/c6B95utfgSvVuRH1
         92g4b4JmWZByADWzmr7IJcDk5ccKQriswyNcKxr/IFeNjSqYBncGwq/BsZpVT4QlogYA
         slKSjkVPnpUud5r4VM5TijD/nJPtUnfy1LQyjN8ozeUmQ1yhidDBZlyHgeM5jCT5u66N
         0szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762306109; x=1762910909;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPPUewGB6So9V+6so9jHVW4+5E6VBrMKCWD6USZE7ko=;
        b=hcWxLgZP2tnCHG5ToU18OKRtzvWWwIkAgAMFonyuKzkvs4ULvhYo1bn8XEtjHkigIY
         E76mP+S91Jx3tdFU/eHX3QdyOf4w084P6ek6TlnD2nBZWwUazRjRJggjunSDJLaEHmD4
         fzHCZs+WD/ORy9HoTk7K1R1Xp9QSF2m4qx5uKkmjl6hRI9uVhzEtrPHNOXpMvwYAT0F9
         MqLe1YmKOd3nwvmTNjg3+COs7KbIoYmlt3ojtiZoj0wSlLojcUMy7tToTfFuqfva8Ke1
         pDSciHe9StPlHpTpXeopVtCbCUmGX+anyJi7O29lR0ZMixbtkj6xJ2AKWKXKc7QPwOZK
         hCCg==
X-Forwarded-Encrypted: i=1; AJvYcCWIfzcdzNaDYn2k8TZn7repEOZxjsoKMm45JmwtcsjIAU2YxSmxxWkUWdFyuiWyYpoSnhaqgZ1Ps1TewwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFBam7psmgWJeWHemOm/gs7SHRhJK1y5iEhF/nFwv0QEzbLQJ
	j+JKzP0Ib0wJmwl9dl+1suhh+H63mE7AEuLXcUM31ABzSqMibl9N/cCnf2a8MpqaSY0=
X-Gm-Gg: ASbGncusyErM+JMOzcj62566M+lBwoDLyF6brCNarSKg3dixuSrC8Qt8KIrgjXT41K8
	6MepkBWfLmckXMv777qTR4AnMPC//Q89pGZoQCoJKEJT23nSsuJ+kd/6BfkotCmTMOcxfJvDCTw
	wY6oMzV95Xe2PfVqub4tbhmWZXokgOtOrEsWTo8cbOVuQtbb2jrDADBh20YwROa50B7hpdhb3ul
	XzFgdOUQD82HLyBbJgCJzhsVwexTIbWcoKARGjHixoHp0UDaVRR/ArjhkhDPi/ZH2wmQGETeW2F
	SC8ilGbCyxiNKHrAUZvX5F83wME3kyLRAHQjnTlFAI/ZiHyLxNCFgAXO+at7kgfpvLiae5pmN3c
	Mi2+zZs/ZaqYWLAbgzSdPqUpKF+cF2UQ5CKhIb+8EfxgIus5g/V6cNDQcuHqGZkeurRJkZKLq0g
	==
X-Google-Smtp-Source: AGHT+IFSsqvSbzPcDpvpwxfxx7bbmFddUkB1ctL5ZPjfSWq313S/GL5AMgQivKGFXYYFQL6slLnsFA==
X-Received: by 2002:a05:6a00:6206:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-7acc085a54amr4790544b3a.10.1762306109517;
        Tue, 04 Nov 2025 17:28:29 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd5777b37sm4365070b3a.39.2025.11.04.17.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:28:28 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andreas Kemnade <andreas@kemnade.info>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: linux-next: manual merge of the omap tree with Linus' tree
In-Reply-To: <20251105115402.1b03f921@canb.auug.org.au>
References: <20251105115402.1b03f921@canb.auug.org.au>
Date: Tue, 04 Nov 2025 17:28:28 -0800
Message-ID: <7ha511i7yb.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the omap tree got a conflict in:
>
>   arch/arm/configs/omap2plus_defconfig
>
> between commit:
>
>   c065b6046b34 ("Use CONFIG_EXT4_FS instead of CONFIG_EXT3_FS in all of the defconfigs")
>
> from Linus' tree and commit:
>
>   810c5ef6efe9 ("arm: omap2plus_defconfig: enable ext4 directly")
>
> from the omap tree.
>
> I fixed it up (the latter includes the former) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks for catching this.  I'll drop the patch from the omap tree.

Kevin

