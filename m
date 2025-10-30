Return-Path: <linux-kernel+bounces-878386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A624C207DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F48A1A21620
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F2A1E885A;
	Thu, 30 Oct 2025 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnhuFmPz"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838A1A3029
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832862; cv=none; b=nmEfmaIJa9x6X1pwOg3cgShmmhVg03kZAjiPO+f6MDBh3u66kYe2ObwNdY9kcMORtyDapdiJDO6JgisC90Z11jT09VpymolQ4q9SXdzFr+Y21rsPjw9gV/twiqIcs4QeyasNZ6OM18jWhHufO2POZtSdD2OEdZq1xdUftp/ogz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832862; c=relaxed/simple;
	bh=o8WfBNrywvxmcPzlntg/9HC4HIIWsNpEBRr1GX6catQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Px6EavDkK1UKIgrYX1wgbcKnkTsznFr7dr48heWrgEeqY8sW68CP0V7Si0KEw/u2AC8KgDQJspXGC2fMrZp7P+dAYje7mJ63Am9I9L8Q70p9YA2Pgoyfp3LYlNyMJzcjgUFGjU3Z3br5vtEzhYEnF9VhjnKj53vOJL8NCfO2LS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rnhuFmPz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso11781335e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761832859; x=1762437659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhOsA8UHsD+kgHnQG5bj7evQvukJJELHnuX+mjowyF8=;
        b=rnhuFmPzIqStykreU9h7nBkfcdbyGRbwErU9YwP7NdVU4Xnnq3tQVROMDgO+0X+ZeR
         tEmNY6jJDih8E3aK2cyke7IxLe+nxQGgf3CUMR0dlJaxEdLc7Ovs/zjBD9Y3T+F8ISYU
         KYpk4zekB0uR3bDTpMYBmPnwSQbuRPtzlh4RXJ63fkabWn8CLSKVWBhjzTySwRWZb90X
         me/edQhAkh5Yx6xqcF4p0SwdZUZV2VUMymJmL8SFvkqkjFCHwUPTZPTduEUtIwputTHx
         vLyGs/0vbylFloAsK0CfUl1DrApjavGdqT3Co82CYBTxyUEzBVcY33wr+aVNY6W0/AFb
         qnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832859; x=1762437659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhOsA8UHsD+kgHnQG5bj7evQvukJJELHnuX+mjowyF8=;
        b=apjvmZTdodq8dP3cBp7xsozhjdinsowg/VorXkw3kXum3cHtb7Do5hOtBUVHN6tnje
         bZo+ctPKEn3t+lyj6id6Ew+MyQO9n7PJihc5XcdMiXXBOyNxR2F7n4KOXWMctZq1zdzx
         zfHAfxmJMbowf8ULWhetOupIkbofcUmN/66pYIsrF+l1PPH1FtnYfO3fwSuD58LsMv6v
         LnjUgeg/LSSyuNxn4gwXMkkESG0scrY7fGLM7MgN/udHsGNKUwPBVNu9RUnuI1K2HRfW
         ZnocdTe0PYBdBy4pfpAWzBwVZkncjZ7GYWoFlw87HZqpyKTxGpYVRx5Ijf3YtEVuJZST
         0XzA==
X-Forwarded-Encrypted: i=1; AJvYcCUQqH1Oq43F2PSTIXlK9HDwA6nkqRWq3VuKCHwaErTvv4dc2SwKKA8Hf/ecmxRGcQWtQdJKTBM2Wrg8ZoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/6JhZdbcHnxmwKyqp1BGEremFjSVe3xWWHizSuXnxJq/s8Wy
	GKaql6UeckjY0gWvxG2N94yPljYd2hv5Sy+EUoijx38MdkkBz3+vYIyzAH+ItX2Hug/HJXGu3Qf
	0NNH6Gtj1E1YB5Q==
X-Google-Smtp-Source: AGHT+IFDaUTBibrp5YvovgZGztDFvYuBR6JcNr//76jIUfw4OooUFlcB/OZZF5LYyqq7RIE/k/er0tNN/R4SlQ==
X-Received: from wmco28.prod.google.com ([2002:a05:600c:a31c:b0:46e:2f78:5910])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8306:b0:471:c72:c7f8 with SMTP id 5b1f17b1804b1-477222fe0bfmr35058585e9.21.1761832859652;
 Thu, 30 Oct 2025 07:00:59 -0700 (PDT)
Date: Thu, 30 Oct 2025 14:00:59 +0000
In-Reply-To: <DDJU0415JEBQ.H2SD942NMDWX@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-l1d-flush-doc-v1-0-f8cefea3f2f2@google.com> <DDJU0415JEBQ.H2SD942NMDWX@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDVPMHX51EZE.1UIA8HYYQZKQT@google.com>
Subject: Re: [PATCH 0/2] Documentation: fixups for L1D flushing
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Balbir Singh <sblbir@amazon.com>
Cc: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu Oct 16, 2025 at 2:54 PM UTC, Brendan Jackman wrote:
> On Wed Oct 15, 2025 at 5:02 PM UTC, Brendan Jackman wrote:
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>> ---
>> Brendan Jackman (2):
>>       Documentation: clarify PR_SPEC_L1D_FLUSH
>>       Documentation: fix reference to PR_SPEC_L1D_FLUSH
>>
>>  Documentation/admin-guide/hw-vuln/l1d_flush.rst | 2 +-
>>  Documentation/userspace-api/spec_ctrl.rst       | 6 +++++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>> ---
>> base-commit: 0292ef418ce08aad597fc0bba65b6dbb841808ba
>> change-id: 20251015-l1d-flush-doc-029f64d2b0d3
>>
>> Best regards,
>
> I just noticed another issue - the docs say you get -ENXIO if control
> isn't possible, but for L1D_FLUSH and INDIR_BRANCH you get -EPERM.
>
> TBH I think this is a bug but it seems like it's still better to just
> document it than change the behaviour.

Since I didn't have to respin this series I sent a separate one for this
issue:

https://lore.kernel.org/all/DDJU0415JEBQ.H2SD942NMDWX@google.com/T/#t

