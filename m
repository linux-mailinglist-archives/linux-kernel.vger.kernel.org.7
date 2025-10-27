Return-Path: <linux-kernel+bounces-871937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E7C0EE60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B19400CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EEB23958A;
	Mon, 27 Oct 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep4iqc0K"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225582EDD76
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577815; cv=none; b=It7F7ox7oRGY/76O7NaJrNn5fpSFk9UMbedQZeFUic+p+ja+XD0bOewdTah2PH99kJ8Bfgt8phPhbcyrbxbFHl0xvoxb+58PtDfef5RZCpOUeAWQEg/i/jX5BnecaHbWTvamENsdJKpbrM5pg6i8/m0Xb4xfDLHT5DWjPUNTvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577815; c=relaxed/simple;
	bh=P4gxh+sX4gDn50DCIKBIonCfr6GljY6Yg5PZOosv6Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlXC2YfHwGW63KrkIWs9DcQb5FPqo9o4PWFnQhr+9B23bPOhuKlOrVLXosA83erdPUiy/mQVhDxPyKcE+O4isWrxIK55PZ3Goyo5vX5u+Kkcb4hRhRcfLK/5Kze+Il1Pwf6uyelfgCXkfEwBWfVRqU5z8H7xeMKXTPt6pqGsO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep4iqc0K; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290a3a4c7ecso53873585ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577813; x=1762182613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KV+dgU1xy8Q45LHOdAS8jfNYlLbRD459gKkW/4NsZBU=;
        b=Ep4iqc0KJ/wD8/g/o1uy8b3CdjNURsX+YKZg+isRnDsN97vi7H5S9dhxR0qtz/FqdD
         zToFpvV8xpGjP7D08fKJo3WcvQjXBMYVYilj1k9H6UlQ3lRn+Vx8BCDPLJSp8O3/OVwZ
         RKdeGpPbO5XclCapzAA3AYtxx/wg4Fa3Cm+Z0WPhwNeM1bLIObt5JoXlM8ca7A/VG9RE
         PM2og4QsBKn9g6dpso3vn+SHK1k6p8qTMHECG7S8sr0jRmSRv5wfbM/CC/ohWiRK/U0T
         n39rTnLBx8WbQs7IlxMAb42J/Gj/9oa0llvkkid13AhDTavRxiQ9VHeGFOZQRfr5Add3
         E1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577813; x=1762182613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV+dgU1xy8Q45LHOdAS8jfNYlLbRD459gKkW/4NsZBU=;
        b=kBC8f45TfnQG3Fo6FvvicnU0xUoYqAfd4krVt1FVbRAm7iWN8a2329n5jUT4yoo8Z8
         kM1Qm0Fr/8ZtquegUTDa5e2LkWHsjlUYk+vnWLET/ePxCTB4O9Lj5pLU5YQkkDlITO0c
         Q4qBi5NMEDTt/RmytJmVvtyXR2mk9zRlzhAjo9QxLJhNA7ww4k1PjcBPVdCsObDzH7pG
         HTrcU/DVSAUBZ91PARCQBuiJsY2WMq/XYPgC9P+SfkMAdDibs7geyEIGIJyZhhXOxVzY
         /nHNp17Ckd79B2oC0xvIMWrcm8fu684x6aLyVCn6zIXX1Cb9QuU+VhRFPpqHSTnAs6JU
         BWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdUkzYyG5IHBkSfLUJ72hgcWIzmMXXF3ZwDh5vyseCfUW1QQjVb7Cep7aDCBs6DBRI3hLOnTgtM9t8b+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy03zMzIzlexh7YnyF25/yxmML/uL3OAzPEeA+BjaUxUsN+Y+Ta
	qAM1u/Kjx9GYxqH26C059igy77zaOmKIghNqhkPKdIuYv4Q06AQJ8hIt
X-Gm-Gg: ASbGncvYly33D+ehzQZYfsCxjUjTE8Lizo3yBQPDSTy6ta4nQvNXaQrcv4u7ewazsuX
	MSEeb0Mz5FEXZLrPxycXYWmWnxQRpRTh6iNsc2F5//T049OlBfTjf0ivI4ub8f95rUo3CJa0BcP
	3TwGM1WACq8s7nJvQ0oxXT4kTSOHryexaGQ3UTzOlJMOaaIHNZ5XcO4ZZLtI07punCvS0UmFWT9
	HSUiF1C4nLGBTuLUE58Y8RW/aqs/bfcHmRDu1q0FZV2+2E7PUh+p7uzMRoJ3FpGzQWZJgg+eXO+
	aBwoifhAoJdrxLUfK5pN4b9j3A2RgZbxB9q55yiJxjDZ95OMjhUIpJu8DVeFDeKA37hK2g6p81r
	HFRZZbTEYDkut566F2ywcArhOuOTIElaC3p+JZzQlq1Tru7CPjwFy4IXx++cbDmu0Tm2zGYiL+u
	C1saJNKlNanDOiAGlIY2ECUwYSfN+4QDUj8OLiAnNKOAf8h6nO
X-Google-Smtp-Source: AGHT+IG2o9ZOMRiQToH4/Mv8njWDHz1vYKUsJvwR9D8DktGrc5VAjMxjT8KumWa3rz1I+qjC55ilOA==
X-Received: by 2002:a17:902:cecc:b0:276:842a:f9a7 with SMTP id d9443c01a7336-294cb523d54mr2795155ad.57.1761577813098;
        Mon, 27 Oct 2025 08:10:13 -0700 (PDT)
Received: from 2a2a0ba7cec8 ([119.127.199.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2333fsm84223145ad.50.2025.10.27.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:10:12 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:10:07 +0000
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI/aer_inject: Adjust locking for PREEMPT_RT
Message-ID: <aP-LT-IgxbZMdWNt@2a2a0ba7cec8>
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
 <10579b1f-1005-4842-934f-0b9c6b65971d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10579b1f-1005-4842-934f-0b9c6b65971d@redhat.com>

On Sun, Oct 26, 2025 at 07:16:36PM -0400, Waiman Long wrote:
> On 10/26/25 12:43 AM, Guangbo Cui wrote:
> > This patch series addresses locking issues in the AER injection
> > path under PREEMPT_RT.
> > 
> > Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
> > ---
> > Changes in v3:
> > - Remove unnecessary lock in aer_inject_exit.
> > - Link to v2: https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@gmail.com/
> > 
> > ---
> > Guangbo Cui (2):
> >    PCI/aer_inject: Convert inject_lock to raw_spinlock_t
> >    PCI/aer_inject: Remove unnecessary lock in aer_inject_exit
> 
> You should reverse the patch ordering. Patch 2 should come first before the
> patch 1. Otherwise, applying just patch 1 without patch 2 will fail
> compilation.

will fix next version.

Best regards,
Guangbo

