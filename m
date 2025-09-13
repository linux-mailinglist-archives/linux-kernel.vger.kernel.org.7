Return-Path: <linux-kernel+bounces-815064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7E9B55EE8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB041B23C9D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5B42E719B;
	Sat, 13 Sep 2025 06:17:26 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B702E6CD0
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744245; cv=none; b=AaFv0xsX9btUW61PjsKD37N6JqPwBaDZjwFwNVz3fW+w2WWFg7FiVdZ4xOqrL/fUlCpViNfNP4VAzrsibXciwFeupRY+KvuCPGxhFpcY0nsAMqeQ54P1RXfiGz4lIkM9yJ54hNQlayX+9IETQGU0j5I7vLR0HyzQ7gPhe+z2Qzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744245; c=relaxed/simple;
	bh=wuvNk7YIn1aWYwCx2L8K6dZ+hjBFxAZx4dZTxeBRP2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcQmOpi/HlXr1c8w0uid0izvElugCqEwDPpbBYCCYevo8nStciyQYaEiWzVRhbpevtQNQze8ZYQpV0+S2Ce8VHrW/MhihftEIQ8ZWZsHTEzRz89yOttPXhTj9M1l90ERccoa7mC/P2Wweawbx7zzgziS8of/L/1FZ/XAcIiiraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54b3cafdcaso727195a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757744243; x=1758349043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whstITD7FD7VzEh3PkMP2EuVC8gwBGZYuJNdrrp6Ya4=;
        b=SMJrsGt4bmTQ5oLUJaOonkm13WJbMg23AytbayCqgnWot1C4v5gtZ5cQPLRL9PakeT
         r9e8BONr7SIoF4WgYz37pBx//qzkreoG1TlKZBDFPRpe/ptTVJY2HWvAiX+k187Q1FbH
         1IhSu3gnzq4L4kFPwFPmP5WPfhk2J/13BwAklx+iX2pTbLGGEnkd6rEjvSk4HTpv/HTQ
         anf8CloLUNFn4uXWh8SUr+PebMajWbTaRbaLBZ+7v/gXEfZQGu80IE2y4vTQpFO9IH0Y
         pBz4WffVf0VRH0BeO3i0uqioCHHcf1skvJMKKHdeLUhsoCw70XphxqkaprNSYe+kXu4V
         wl5w==
X-Forwarded-Encrypted: i=1; AJvYcCWCpaW4kyn3lkMtcEOn4iD+aJdHSZAWJOdmra1RQWTWryVcOd2uzbI/ERHw5zOXYpUHcTpZXPSf9lX2Mog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw8e4npFsVNWFg6baFxh73AqGXNZUyPnaBlAVyENbN2kf19LY4
	8qrNaKOS8ubWCFAiw9ztUBClJFy2wkzsjGFKMz80xcUFo7NKeX+LRwOW
X-Gm-Gg: ASbGncsWKqdLMKyO0qkzkjnVkrPNhZ/o9bb2DbY831TmierFbzX3O7kL35IA1qz8xaO
	tPQan8T/J/PE0TjZLX0dFFBd4hKSLJsPgfJLx7dI1oBraf5CBHBJfcSuJXoXocPfv3VACqFwHRI
	d03wu+gGzeu4fSO4Ivy6G9RcOFz85fTfNqNXXY25PD6MdIv0CefiQ7zfVcIxmz212EnLQkEVMCt
	UNTdF8bzFPtAb7Rwxw8wsq20X7kesShJzWqawoe6zuW7/iIjZHzkH+s8YmTPkIgYdyQeDRaPm1c
	qYQ9tMxgT1w6XcK6oANbftcm+aZ19idLqD97brNLjTauozBRYkyB4+0feQ8UTA2Gvyyl43v5EvU
	+t51LlVXBQHRto/YaE1ktIrJCoE9c+NyHw1AebZKitu6XiqF1oMZAkYGQNUgkZL7KQpCl
X-Google-Smtp-Source: AGHT+IErQIvtqKLR1glNnSs4Q72WjCl8l+b6YxbIU5vQjpqoMbOaYdi0OfoKQe75DvLs87WIodEV9A==
X-Received: by 2002:a17:903:3c2c:b0:256:2b13:5f11 with SMTP id d9443c01a7336-25d26d4c335mr61440085ad.40.1757744243128;
        Fri, 12 Sep 2025 23:17:23 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25c36cc6cc5sm67443515ad.27.2025.09.12.23.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:17:22 -0700 (PDT)
Date: Sat, 13 Sep 2025 15:17:20 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Matthew Wood <thepacketgeek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250913061720.GA1992308@rocinante>
References: <20250821232239.599523-1-thepacketgeek@gmail.com>
 <20250821232239.599523-2-thepacketgeek@gmail.com>
 <aK9e_Un3fWMWDIzD@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK9e_Un3fWMWDIzD@kbusch-mbp>

Hello,

> Can we get a ruling on this one? It's pretty straight forward
> implementation exposing a useful attribute.

Who needs this?  Why is this useful?  Why hasn't there been a need for
exposing serial number in past decades, and suddenly we need it so
desperately?

We probably wouldn't want to add this if there is only a single user that
needs this, especially give that userspace tools like lspci already expose
this when someone needs it.

Also, we were reluctant to expose some types of information, like serial
numbers and such, via the VPD recently, so why exposing any serial numbers
via sysfs would be any different?

Thank you,

	Krzysztof

