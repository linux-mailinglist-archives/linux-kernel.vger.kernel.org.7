Return-Path: <linux-kernel+bounces-840861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B50BB59AF
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 01:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4E304E7B43
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 23:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990A22877E0;
	Thu,  2 Oct 2025 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gimpelevich-san-francisco-ca-us.20230601.gappssmtp.com header.i=@gimpelevich-san-francisco-ca-us.20230601.gappssmtp.com header.b="mz5doHAh"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755516132F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447248; cv=none; b=nh4dIJ/MlMtf0nopvOWm4Y4jVr91R504DSL559JF3r0TNisuewsLCgibwIRxZvBBwnzciFW7Je925oXVwsq7ldWvnIEcCzlpfZfUVEtdAs9fVylU+puVoEporO2urICuj7UK+EGZaKouBDgCM3mc66XPP5u6z5hVJs8dUdyOQpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447248; c=relaxed/simple;
	bh=sXiKQiWwINtaw/0i6ZrayWsPG/BbPIm1nQreVZ4vdDY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=Aooa4ZadHAsgFMDaCtRIrkUybRIDH9uH1u5xi1pP+LV3j+zZo2gCuTvC3XnQnKq8QC17Ntm89+xIEr+5C7G5dcILHbUuQx08ragbKGNsPeNF6ZoG6yjDxreMVq7ejG21H2u3oMYzNiPUS2oQnuFezk0y7Bx/DUqWTBvteInBB6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gimpelevich.san-francisco.ca.us; spf=pass smtp.mailfrom=gimpelevich.san-francisco.ca.us; dkim=pass (2048-bit key) header.d=gimpelevich-san-francisco-ca-us.20230601.gappssmtp.com header.i=@gimpelevich-san-francisco-ca-us.20230601.gappssmtp.com header.b=mz5doHAh; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gimpelevich.san-francisco.ca.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimpelevich.san-francisco.ca.us
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3304a57d842so1551277a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20230601.gappssmtp.com; s=20230601; t=1759447246; x=1760052046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:disposition-notification-to
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gX9KJbRliuDiUhyueXfwx/TklBf4F3VVV79ND/TcypU=;
        b=mz5doHAhq5A8MhgmoD739FYFCwApcY34qUfictTf8y0NjFg0GrmJSledDn5pYCMbV+
         3j3x//1jJR9PVQh/4/79UK6fkQhZ/9qQuwqLjSyJzTZgp6LPr4yLuzEh9uYe0NN68SJX
         rU8JZGKXiAHxR8kcMgdihJTMuWYwRZ0N8XSoBagUz/k7asMxpPKXuZzERYHk/d2Wxi1k
         E6wl7pUWRFTpI6qxIeWC0GoEIFXvOrm5tQYLvtVKNyB1R8IeZbhsh0mY80T1KNZ2F+Fy
         b1hAzQz9mEPm2F7+ecc8ydrD0eHSu/SAT2BpqM3W1Eaa8DVLGxwH8Zpxios3qNGGkbEk
         RPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759447246; x=1760052046;
        h=content-transfer-encoding:mime-version:disposition-notification-to
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gX9KJbRliuDiUhyueXfwx/TklBf4F3VVV79ND/TcypU=;
        b=kMPwc4Dz+yUjRp5uSrXmIwONz5M3NxGjjyBCH+43iegQMwBfkoofZtUCWPZxRgwOKo
         xzRmJ+x4KGXjNuDjeNaCZrD3PWqIFDY93KZuD1SSrABdrDI8t5KaGTTwnoD6RIAg9so3
         VdQvOdmtIHemeTiOrDgBrw13LQKpuxhbkIatjVopZjmsAX2zeKACwtwnz2YHQAGAxVsr
         ThBM/xu3/wmZ3U3SCc2ftkV+xxIc2UDtvEz5NAepjP6JF57FlkjOrS611xTIhPOVdn/X
         ofQqTz5uRkD1S4vC+ONbc+tjvhVtCemaEld6AMCdlegYUm8CuvTQJgR7/IzaaC/4YUDm
         lokQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1CoRsIAdj434dW9d3etv+/1OPnMTuczUVSeGuRpN0taskyctClGTG3tc3yFokp9s5R6T+9RWjACNFdgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziYfd8QNl/wmqRl8iTE93G+J9dt1EpLHpnsCRTIzAvABzGIgVJ
	AvufUlIP7tANsynjCy7p+xsKPfhSBc4pX0qNtKuWvZL68/fkD4Qm1hcYI3qjlicm0w==
X-Gm-Gg: ASbGncu0h2l9wk6YQsnrAYf95qK3NnRLeuvHxT9DILqfznzcfRvGmTBDnBh6Yl39FdW
	azeh/aiKtfjVAICZxxZHcX9fb600B2wFSEoVPpy1tKXM4JfsjfiytF59mSm4wK613flq3aaGpBu
	1X95T2h3RHOoxsDdKxG2GpWlCLFj1ZX2mjDUUXLj6oPIqBz5u2X5h+86fW0hBIH/nEe7O34dYGc
	OdNRpJtqty9Rl675+hLMTIvAAgLva1OwT9RdidtwltXGVoE/qBVCTApgIZfPrn0qJ2F0OndjM8+
	UbS2msDEJVaObj3AUt/ziGr2YRNjwBqgng2voUx6Y/7ZQTyNJ1zeKsftfblOTZiOisGUIHBGYHf
	UDqrLIFxSouM7qnLe2aezv22oCyWmNEAxCEWQdignQEkXuZQDFNI6/j81iF4mYJjbenGESu+6Vo
	jr/lrmfe1HsZW9xa6Ccxck+mWh1cqvjDAKflZvc27LsDc=
X-Google-Smtp-Source: AGHT+IFxx2TCD6D7jFtBEJ3PbntsdESkjjeH5wij8/VnSkkJDYC5xpM48nDuzXv8UOwcied9Nu59sA==
X-Received: by 2002:a17:90b:17cc:b0:32e:5cba:ae11 with SMTP id 98e67ed59e1d1-339c27859aamr1054843a91.28.1759447246577;
        Thu, 02 Oct 2025 16:20:46 -0700 (PDT)
Received: from ?IPv6:2001:5a8:429d:8700:4825:53c7:1977:212e? ([2001:5a8:429d:8700:4825:53c7:1977:212e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff0dddsm5947685a91.18.2025.10.02.16.20.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2025 16:20:46 -0700 (PDT)
Message-ID: <1759447244.24579.14.camel@chimera>
Subject: Re: [PATCH 6/8] CMDLINE: x86: convert to generic builtin command
 line
From: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Daniel Walker (danielwa)" <danielwa@cisco.com>, Will Deacon
 <will@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Rob
 Herring <robh@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Pratyush Brahma <quic_pbrahma@quicinc.com>, Tomas Mudrunka
 <tomas.mudrunka@gmail.com>, Sean Anderson <sean.anderson@seco.com>,
 "x86@kernel.org" <x86@kernel.org>, "linux-mips@vger.kernel.org"
 <linux-mips@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>, Ruslan
 Ruslichenko <rruslich@cisco.com>,  Ruslan Bilovol
 <ruslan.bilovol@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Thu, 02 Oct 2025 16:20:44 -0700
In-Reply-To: <dde17d82-3e56-4b9f-8b6d-dae3d523d44e@intel.com>
References: <20231110013817.2378507-1-danielwa@cisco.com>
	 <20231110013817.2378507-7-danielwa@cisco.com>
	 <00c11f75-7400-4b2a-9a5d-10fc62363835@intel.com> <aN7n_5oiPjk-dCyJ@goliath>
	 <c8b65db3-a6cf-479d-9a83-23cbc62db1ef@intel.com> <aN7vKgcUeQgCFglQ@goliath>
	 <a2be781f-96b5-47d1-81fa-b20395ca293a@intel.com>
	 <1759444692.24579.8.camel@chimera>
	 <dde17d82-3e56-4b9f-8b6d-dae3d523d44e@intel.com>
Disposition-Notification-To: daniel@gimpelevich.san-francisco.ca.us
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-10-02 at 16:10 -0700, Dave Hansen wrote:
> How is the approach to "keep it atomic" working out so far? ;)
> 
> The kernel isn't exactly developed in secret. It's also not hard at all
> to, say, once a week to peek at linux-next and do a lore search (or use
> lei) if anyone is desperately worried about the ~50 lines per
> architecture going out of sync.

With all due respect, the lack of action on this patchset is not at all
due to its scope, but purely due to the throwing-spaghetti-at-the-wall
approach to code review that you yourself just got done pointing out.
Addressing the latter problem would thereby also address the former.


