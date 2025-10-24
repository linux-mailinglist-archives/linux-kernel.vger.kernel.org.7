Return-Path: <linux-kernel+bounces-869550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71870C0825D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD66E3B7033
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027C32FF164;
	Fri, 24 Oct 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ty+4ChrG"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D32FF15F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339937; cv=none; b=dm6Zg9jKOpbmsdJE1pzjTvETP0sscunXPfXXDRmCoH+fHKUChcaIp2Foqw6r012c4j6PEqFsG1eXUfuz41IKFeQFXW9uxF23fEnfXItLPi6118biWozxzAh/g/EfFm/30Qm6RbtlpediMbA2Rn7l9kTH6+7umcE1mricmuhuNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339937; c=relaxed/simple;
	bh=S8tX1I3NnXmp83ECQLkp0HtMupL6iB6KWNRunTE4S4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YhC7Q6w9dn38/bn1j1951k//K5iR7ZVRUfJ7K12/kL4sMhk/GyQF+1OPcuozltDQSSq0bAAIzJfDKma7rX5AoOmB7SRQP9ZXPKY5k2d3YgwjipLzGis5x8l6hWgJXL5ioOKktgaryuyXT8hSGhkxNZ7VaAL0JpQsGr7ZHxL5ZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ty+4ChrG; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-63c585eb47bso5331175a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761339934; x=1761944734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UyyDskZ6zQPcCI/8YHZiXytq5M9mCn+dOU7TwJSjkxw=;
        b=Ty+4ChrGfh8VhUR6/DPJYhGnDEmmB3lPuUe5QvOzHWiylfnHAgJn4MP/3pS5I9h4pU
         vM3+6EPHP8kT2D1ofr0ejx5Gw0N5PNg47bOx9v9ZbRSBU3danb2W9oRT5Qf3VRhR7tFH
         V5sLS8X9Mq/VM8J5mq8gzZVMgXPu980+uNTmRleB0HtIvyQpa4zDV/IRefwquhmjLtAG
         4LvlznSfFyI/WkFSybH9gfiVmU+TYtFAMHYwA2oAm58yxrMjXRitIZNs2MnVU8iq3Ye9
         QqhHz/utC9va7kmeufpLYCFOzZOxaBK8jbAUkeZdhaPwTbHJMeF8pe9pqIm/dIIIxotN
         TWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339934; x=1761944734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyyDskZ6zQPcCI/8YHZiXytq5M9mCn+dOU7TwJSjkxw=;
        b=AYJXrWhi5t6EVrZp1cQ5PoTu63yaPrEIF+4HwHpVKiFMiRn+1Zx71UnLKTGfB6juHI
         3emMUfX+XuzsQ0lHwsp/6bNOf1I5BANuwiCWYcDaAvy/eBX+x5XTQFD6z86E+NZ3/GJQ
         sJKYT7oAenjqBZxh6Sp2pAyJqJaGOuQcK3FDmROkuEOtFSHl3Qt8h8MA6hvP8/UTK7u+
         s8OPHEOO7DKWFuwknSDO6Mf22IkbPoHT1ee4ABqzZuWwbANwzdmJVrsNvM0fPGAFJm9J
         9qGFC3Z/gn3lXJwB2bjq5d+cfAFwkoAHFCjrl15Mk3Vf2Mzvqe3sK9ghieJj59L+hD0s
         PKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYAG8SjmZ4IPTakGuKN42Zca6FRyykwXXQ/yKNMogShlMUw/tQtEC0MIYBv054Yy29Fmh/IOPDgeKgcXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1fmTgLTOALaBzQbOimdbqYV9aQS0Few8rQD+c7B6QNjceOXD
	CkjmrArHWmkbC4G3mzp/CIM+wKRP+D4N09yS+GuHo4d4u0JPBAJ1WI9hebt0p8RQRaugWkKULex
	fqRiH4dSVPEfT5ewqPMQyWQ==
X-Google-Smtp-Source: AGHT+IFgqdh0PGBfpPjLJUmHPsb/alPmW29UdHjvj2vTXlQfjvz+HF6Nq2nius5r1WBMT4eb//7EEJZR468bGx9T
X-Received: from edi26.prod.google.com ([2002:a05:6402:305a:b0:63b:da80:b28a])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d446:0:b0:63b:fc79:393 with SMTP id 4fb4d7f45d1cf-63e5eb4b580mr2513452a12.14.1761339934347;
 Fri, 24 Oct 2025 14:05:34 -0700 (PDT)
Date: Fri, 24 Oct 2025 23:05:14 +0200
In-Reply-To: <20251024210518.2126504-1-mclapinski@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024210518.2126504-1-mclapinski@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024210518.2126504-2-mclapinski@google.com>
Subject: [PATCH v3 1/5] dax: add PROBE_PREFER_ASYNCHRONOUS to the pmem driver
From: Michal Clapinski <mclapinski@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/pmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index bee93066a849..737654e8c5e8 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -77,6 +77,7 @@ static struct nd_device_driver dax_pmem_driver = {
 	.probe = dax_pmem_probe,
 	.drv = {
 		.name = "dax_pmem",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.type = ND_DRIVER_DAX_PMEM,
 };
-- 
2.51.1.821.gb6fe4d2222-goog


