Return-Path: <linux-kernel+bounces-834516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AC8BA4D94
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381807BC299
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3261630DEDF;
	Fri, 26 Sep 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZdUl9+Fj"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729130DECC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910126; cv=none; b=ro0uHyRlrJRlJO7hQ2sTADOeZiXHLYQ9b9sNBOJ1OBEksjiJOFNz0zwhJ4ILDNfMjsxmn6cg6M5xaERTDY2mgJJCSVLnBOIRyXU+BnKdwNdS9FO33UvA6wY47wHtYzg0hahC+sxUQtsv9DLhnzEoZ6qXQZJM+8W/QdWGwlJ58+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910126; c=relaxed/simple;
	bh=/01OVbrqY1/2JAteziqVeUvPOBQ4C3qzeN/sBTR6IAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RdP6h9MppsZquCIYWeo3E7VRFK0Hi8vhb8AfD6rqQTWDqAph/Aoa2EDvXUb1slPVKhQ8EavdEBnhaOwh9D7BMFX62WAABb65W4nvf9CqnZyhKv60TKk55wWJPIdWDGU7AdByvfMe6OQNIxKKLt1XUTUUbK1s45bHrxe33OXvTAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZdUl9+Fj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b2d116cd1cbso44094666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758910123; x=1759514923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YFxqmy1UOqhT8MvDvvyaobsR5WofMT3SRajdPJV5Ytw=;
        b=ZdUl9+Fj0hOSYg465SYY4d7mCpFNSbBUFLPU9/dNAXipSI0yPS5BTuVzXZbdG3B7Tz
         oYOWSWMWKLvB1WR5SMY2GrCHEW22fIJgOPXNsS+Lrvm1hXyjTEJOWiIFUXmAlRMN4XfK
         XO4Al9+OdRc/DTJ01SmPxwe6yD6uMEzZPdO6CmNvw9AjAEcqeB3urDwWXygYjXhTH0bb
         x8QWnRa/Mee+WkXGswpOJZj9BHOl21Ha+Nud0vKr0w/+lh5usbDEOXlUv+dmTPqYOhqI
         xhayXzSr+cVtndtaZp/tQ4dKQ1JPw1NNd29x5lVG0gTHS9zsOj4MgwH9+lreIQxZba6/
         x6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758910123; x=1759514923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFxqmy1UOqhT8MvDvvyaobsR5WofMT3SRajdPJV5Ytw=;
        b=FaKCf7lahY1tGue9u0xWOIgVqi3o0W0MpOSe0in6bfCYUPIjH9s1Lmb0bSvg5iuuvg
         NegoBF5KWyYIgok0x9DxTRCM5K9kdoR+crKEsBW52gKr6QqQbcrmdfJahM8A9OSGnt8E
         4Qb2/vQIuLlSR6wp/JuxffM0rOoEt8MFMToJpxyGxebOGMNetiqKw26B7LNgykglJGJ7
         Z0EnhC4Q/UISriYiFZj9zphp13/Z8Fjp4OHh9oOMs7/3BPqj4IMjOHP2Cz2XqZvE4VnE
         ZmHo6U6WjT4/gH1i4b3MwwqeHrOTV7DMP2WvANi8rmg7uL/JsVmHstgjBGlnfmVqh2Uc
         I1nw==
X-Forwarded-Encrypted: i=1; AJvYcCX6/fEM7/v8RaxGrkwPUIYBJGhQXUcHcL+kqrevqZ3hO0TkgFgSeCOBQhNPyzDcQahOIq1UQqRCXHqm1QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwlTqhz/qc2IdR51Pb7ki68wo1nNya1g+m0lWsjEa69GEM5yeK
	B3N4nmTolOu9l5rySajnzDBWJfk3s+2gaOwFkWm1Gw1E9JfhCADL/Nng7Rdl2fzoYSThn49H/+W
	Uq3b6
X-Gm-Gg: ASbGnctGu61IcjJIMjOqiOXL1By0kxMF/x19j/V40KdUiJDpWBqMLZJHPBVhzv+gtwv
	cmJdq/BQCsFgC2buzrnNkJGyNA8q8A9uZsQ44vdGkHaftRZhQDeUXtXrsu+R6D+D3gBer4luPfP
	1VQ79DYiw8pMWeWKlb51Ud/Naqsx27vq/9KY5meX06O9R8Y7AFdH2eApSWjtQ/Pnepk1sZcVYzS
	/TrzyM9AiAC1aEceVelfLyuYoSd0fw4iN1Sh/m9qS/9+dutDV7lPJZ1wKdRmhzmztdHxCXuWzyp
	rsepQnuZ0Ky0yGkVbtLkxozZBn+hC49vKk53ddLBexzg5SCI7FjjG8TV0B6EWHSzRkjCXGKmPhl
	Khgnhaje+j9WZFZm/1pXxe93VawhR1u0OQbYu8AtJU0K7szVdTUnompHn7FbDPJGEYCfTw1nyKN
	lz6faie9Qe5bQitA==
X-Google-Smtp-Source: AGHT+IECCGYm5Vs1ylzg+CUAIXLN487mRw25AeWzQh+/fZAD/kKYYlLp3EPvmnhb1C0Eel2LURocnQ==
X-Received: by 2002:a17:907:c22:b0:afe:dbfb:b113 with SMTP id a640c23a62f3a-b34bf56bd7amr494455866b.10.1758910122622;
        Fri, 26 Sep 2025 11:08:42 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b353efa494esm410272866b.25.2025.09.26.11.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 11:08:42 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v2 0/2] x86/tsx: Improve handling of the tsx= kernel parameter
Date: Fri, 26 Sep 2025 20:01:00 +0200
Message-ID: <cover.1758906115.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the tsx= kernel parameter with early_param(), so it is not
reported as unknown.

Changes from v1:
* make tsx_ctrl_state local to tsx.c
* use early_param() instead of core_param()

Petr Tesarik (2):
  x86/tsx: Make tsx_ctrl_state static
  x86/tsx: Get the tsx= command line parameter with early_param()

 arch/x86/kernel/cpu/cpu.h |  9 --------
 arch/x86/kernel/cpu/tsx.c | 47 +++++++++++++++++++++++++--------------
 2 files changed, 30 insertions(+), 26 deletions(-)

-- 
2.50.1


