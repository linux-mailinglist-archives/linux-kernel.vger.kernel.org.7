Return-Path: <linux-kernel+bounces-870913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F3C0BF82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E286F4EE552
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6B02638B2;
	Mon, 27 Oct 2025 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndd+dU8Y"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF924E4A8
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761546983; cv=none; b=K6wUISHLdw6NKx0xfIl8pjxry4yQniVhWemzUbQWR3c6J8GNbQSVr48A3U69CAVP/RbTaxDo2oLXcFmypB1+7hmuD0kxYP6Q0RZX4O8SqPN14dCdBHmyljTaVtdAZyenk8+gZ+R+TDRIyS5aBloGyHI5Y+MBtCLZhy1VMXSPfoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761546983; c=relaxed/simple;
	bh=Bnbty25sSLLMCOz2s0nvo5+AElrsKPqVJYJ61QLOW0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F+xyGdbrp7GUae4E6CKg/8sDc0DCfxp3mKrMBml9qpQH9P9MkNfT5btWTSALGQfopo/ce/OVD16L83QPEFuPBv07AnAdYweDE/biufTHrh512aMtS5wsxSOl4QjvawBO4K4zt0Tx0Umya7FcYlqA5l7x4m+GKBdR/2xCn7sCftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ndd+dU8Y; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso3210883a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761546982; x=1762151782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vnY1LLRfagjbacxemgPaGAtCunFHlkZJbP+MUimHGY=;
        b=Ndd+dU8YeAFK92dsnpe0dehUSc0FlmY5ADO1Xu8NzJjwUvVR2KbUi8ItFYlR59yb79
         JAfHujAhdDXNY8hDwH7UwcY1ZrkNLTzflMDWO7sj63DIg1MFHkvVysbt4a/SH9GjLhwe
         3z9Rri0F3vLfQibU8qzLWbLkUfX+rg0P/OVjHIyQQ4KbsufkFSLlbG9Nd0JmK68U5l2M
         8dQP98MS0dWHIALwHxc/VfbFfMFoHI90oZIubYqiJ+3CnPBsNfC9/88GaNqCGv4JjUOn
         vtKAEX51e8DtT7vscIckK8pMuZ4dh6Au+r0hTEQApiN9m/p0aUo8k4iGdQMeK034Ugjl
         k8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761546982; x=1762151782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vnY1LLRfagjbacxemgPaGAtCunFHlkZJbP+MUimHGY=;
        b=rF5Y7t6cPWkmLn0h8IJMGZ8PhrEpxM/XYvQbbuqtARt9t/9O7JBCpFQ8bwsxDjgW0X
         NFQwN1rWJvYSUTc8RtLTr8YYSl7XoYfl6OIPSeftif+iWajDFSpO2N7KQldkHr0PJRvo
         APURdV74wv6wwezHgEPtMq27s7R5hapn0D0nlLY70JjYvnoDs/GJ6/xUn31dIsU9mPCI
         hpXD/dRn470sEcqy++vwnx/O8rNFzuW+LVYFXNQFmAg/7YaOw6D4s6tdK+CTEn4LHz5a
         UZ57W/2gaauj2weXSNs1ZTODIO8u2LamexYJWwrZ7OHos+ZFkJEFYrLqHbDBZVOBKZQe
         jnJA==
X-Forwarded-Encrypted: i=1; AJvYcCXSN6kB7Vv4O4s+JBjWIzStxjYzGrCnlIWrmktI+IELc4TpAUagtfN9zcUaO2Q7hkS+OQt+yqSjuVB206A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/JwQv8js2RNAWXp2Jf3HtoOH7kwAf+bGJ+Ek9r2hXo2iDJs0C
	q/xfeNIZCQWp+4VS5eke5E/zsWrzUANaYzJ32ES0j1XqHG+/5egIi9Gb
X-Gm-Gg: ASbGnctjlrof9dMRFVowKLZIhp1TkNtyzswWLD2eVyxQPjps+z2527c/X9akpK0MdLP
	H+YuWiD6dHB0GL8XhmFY/qwvgfiyXxzWuwZxiJZTYmD/cgmn1qZWNXl+9QMGk8fQphI4a/Otdlr
	dcQKBeznKi+QGjZt+jP25VKTdTSLZGJ+alYJDhOEtEUq5KqZOEXqgB7Lj3oYbpqdrazjJXh0rCE
	mmMcsseEy+yS9T1wCxcfImc9CYUSwTg20QKSwwB5v0UlvsfeT6F2IPt0plenX9V5oRfqjS0N5NY
	D+URXtQFuQWNRsBeQ5lHUqF3Lb4BkTmR/Qj4SvqWyTsiW5eCAK9GO+6FtrqnMaIxKGUGiw9pLyt
	C2C1VwjadkyzXfkCpOtx+mlnldPA/EYOGVm7+22eHLrLGRjf1ZmqkxM/gmlDrXBd5Zf2Ppq6ka4
	V3Mk1KeLgqXxDpOhnLSbqDwnExyxrnS0c=
X-Google-Smtp-Source: AGHT+IGXRQgoR1vd+KRuuPWFXG7PBUaMY4+CjnheQ6ZeszHeKLjqsXocdM4qmYLCFOFQxhySXovS1g==
X-Received: by 2002:a17:903:46cd:b0:28e:7fd3:57f2 with SMTP id d9443c01a7336-290cb65ca5emr462828065ad.49.1761546981536;
        Sun, 26 Oct 2025 23:36:21 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fee434453sm2961134a91.13.2025.10.26.23.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 23:36:20 -0700 (PDT)
From: Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To: akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com,
	dan.j.williams@intel.com,
	gourry@gourry.net,
	jhubbard@nvidia.com,
	akinobu.mita@gmail.com,
	sumanthk@linux.ibm.com,
	peterz@infradead.org,
	huang.ying.caritas@gmail.com,
	linux-kernel@vger.kernel.org
Cc: Andrew_Su@asmedia.com.tw,
	Yd_Tseng@asmedia.com.tw,
	Ed_Huang@asmedia.com.tw,
	Cindy1_Hsu@asmedia.com.tw,
	Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw,
	Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH] kernel: resourse: Add conditional handling for ACPI device
Date: Mon, 27 Oct 2025 14:36:06 +0800
Message-Id: <20251027063606.7962-1-Chloe_Chen@asmedia.com.tw>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


On Sun, Oct 23, 2025 at 04:51PM, Andy Shevchenko wrote:
> On Thu, Oct 23, 2025 at 04:04:55PM +0800, Szuying Chen wrote:
> > On Sun, Oct 19, 2025 at 03:07AM, Andy Shevchenko wrote:
> > > On Fri, Oct 17, 2025 at 10:35:31AM +0800, Szuying Chen wrote:
> > > > To avoid address conflicts and related errors, specific checks for
> > > > the ACPI device "AMDIF031" should be bypassed.
> > > 
> > > TL;DR: NAK.
> > > 
> > > No, this is not how we should do the quirks (besides the use of CamelCase).
> > > Also, please provide more info why firmware may not be fixed properly at
> > > the same time, so we won't need this on an updated version?
> > > 
> > The ACPI device AMDIF031 is a virtual (non-PCI) device located on the PCI
> > upstream port. Its memory resource is assigned by the BIOS within the bridge
> > windows of the PCI upstream port.
> > 
> > When the kernel creates ACPI/AMDIF031 and verifies memory resources, it may
> > detect an address conflict between AMDIF031 and the PCI upstream port. The
> > kernel then attempts to reassign resources for the PCI upstream port tree,
> > causing AMDIF031's memory resource to fall outside the bridge windows. This
> > makes the device inaccessible.
> > 
> > To prevent this and allow AMDIF031 to use the BIOS-assigned memory range,
> > skip resource reallocation when an address conflict is detected for this 
> > device.
> 
> We have such devices in many platforms, older ones use MFD framework with
> specific flag set, you may check how it's done there. But for this change is
> definitely NAK, take your time to find proper solution (see above for the
> hint).
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Hi Andy & Gregory,

Thanks for your feedback.
I will investigate the proper solution as you suggested.

Best Regards,
Chloe
        


