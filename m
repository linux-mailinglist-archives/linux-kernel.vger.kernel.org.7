Return-Path: <linux-kernel+bounces-780192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD5FB2FED2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2000645A65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE4275B02;
	Thu, 21 Aug 2025 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Km1tZPmS"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FCD21770B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790353; cv=none; b=khrufgawp3uPmp56VdlCjxQJcac9l5YO6DCh0arOJ6YeN6okXqadn9NwsHqg7Nb7LkkMtoBLjW53vo/qdcCI6ZNI2C2kDks8r+kSwLJJj/3xY2GY1zAoHYe3bkT6YvrYewmXnxBg58bwpFBXh0NxPAB8lMWz1NMwXk+D1sNkPfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790353; c=relaxed/simple;
	bh=VFuK0HZ5YajTRhhHOInukTlZ+ae2YwEgdLKTLBpKFB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqPNZJ2hlelDlyCdANWbhEqCdFHFAyfTKU895vQMMK3GtRPL5nYnJMtQvqm2dGCND1m9yqrd/ddKhjwNCGBrhVkye67D5HN8KuDX7oXzcJFh/T2DRCUg4C6XGl8IzGBCJDtLhcScHmkVGbVkF7e/0Q0+Oc9WJ3NYQqniOvQkAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Km1tZPmS; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso794491a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755790350; x=1756395150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9tGCA33N4Dbht2srt6gVgLCTUDFdfO0g2tZNWCaei38=;
        b=Km1tZPmSoSoAac2nCquNxMPqCWk0daVdom4ZcaxveSLneReSzQpZsfKDnnhUYHIRb0
         QDEguQ6sgBYZfvOYu4qsNCMsRCetnMV1Vbo5JvI3DOmrVzzBviAKrUK0Bg+WvuiDcjr5
         A8b5IkDThIyztc9At/Q97/H1Nj7vfl8ZDwf/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755790350; x=1756395150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tGCA33N4Dbht2srt6gVgLCTUDFdfO0g2tZNWCaei38=;
        b=xKB+zU+9rz2i4RTaYIqAWqsebyzE+3VqxNwMxdWmwnOWmoHWdtiBFxJCqgfJVB3WC/
         j2zYCDst8Yq8iqcwQMNJFmH23fJ+O2O6uLnzuPtBdL3byNQ3cOQpdPHOaPeD51IWeexy
         CyYGvv5EcVWDdOdzFVB0f/qxNWQ7snXqq4zM0GIrVs8ctpfCQ4b/OQHeROAXJylh2BAI
         RWUk25zxNOCOT4f50WODu2k8pJz5ZKP0AyYCbWn9P27eqyO/rMqKRs+F2LjsBqFlNWxi
         qdbwDmGb5ZiCS3UZV/OiofdPZPFABrmL2RyGg4P3eN/6Mo/9I3QUxwO0GhjvRCs6NQYB
         HbTA==
X-Forwarded-Encrypted: i=1; AJvYcCW2FzXyCREIOY9K/N2y1pXxtf8i6UiAqHSsIx6gSSQvfA/7uZfR79LBoxxo6+6HGWZWILbDYTxAX+3IdcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXoWlhwFDbDKS7xJS1I+TSaFJW/QN6RtPbxrpJmtf6lDx8Nnem
	Nbjj7uAOpkw18c8reBAK+eblcEPqX6mXZq08C2OULMq6jXi+mShvxaTVRoU+y2QbtQ==
X-Gm-Gg: ASbGncvYjKEvwtMxjSwToNdjRiHT7rtVeuYuckyqQCaeSYHeCB/Z05Gt6gfUMDzbUaR
	6nAhpbO56ZbqmpesowTktaXZYRQEY9KXd/vvhzTY5GwLKz6gIV4Mno0rg8r8SHJaksGU1UBTOe+
	TfH4VWcIjfIX4ylqZ56QYWc++iivFaViRoPobk4xbnfZZ/9VyyDfckQTM/UXKc6aML/GBV06LLM
	g6WpGQEpEYQAn+kFAYzJVEE34FVyWeTYloyLvEdQuIr3SxiBbfnzhaDYFTBO6gCbrUPSMGpuQ2M
	fJjKdzX50Wqfw6AKxZxMbSdGx+zZA/IqVLQ7Sgg7VDLF/CO3dNwTsuJPKDpvVR4jphY8mfA9xqp
	mQemFCo8u6nkCSOk3woNs2KSLh1Cc4Xid85inYFIbsjktzHY3IG6UEEVNUASq
X-Google-Smtp-Source: AGHT+IHa2avgM8a5/Xy2bsYAac5GNu+UWEoSX1GkGxwuwPgkP0F1CSFF0V/GPznubUbho1ZSK9eeng==
X-Received: by 2002:a17:903:2411:b0:234:f4da:7eeb with SMTP id d9443c01a7336-245febef1e3mr46702255ad.7.1755790348778;
        Thu, 21 Aug 2025 08:32:28 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2283:604f:d403:4841])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-245ed339fbesm58918775ad.15.2025.08.21.08.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:32:28 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:32:27 -0700
From: Brian Norris <briannorris@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Gow <davidgow@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH 0/6] genirq/test: Platform/architecture fixes
Message-ID: <aKc8Cz4hgMoJ1v-C@google.com>
References: <20250818192800.621408-1-briannorris@chromium.org>
 <CABVgOSkUT_yYqBvk2-+OozKEBybj-07mcRAVECNYQiw+1P67eA@mail.gmail.com>
 <aKYEVTRhzbXvwlbD@google.com>
 <CABVgOSkfADJGnMekV9Zz4x_Ana2uZYMnca1SDXoJnWjvPRGv8Q@mail.gmail.com>
 <CAMuHMdVichNH4VKGEfDJWB5MTBZMFdh4HXtusb2N_-97RARrbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVichNH4VKGEfDJWB5MTBZMFdh4HXtusb2N_-97RARrbA@mail.gmail.com>

Hi Geert,

On Thu, Aug 21, 2025 at 09:05:03AM +0200, Geert Uytterhoeven wrote:
> So probably the test should depend on SPARSE_IRQ?  Increasing NR_IRQS
> everywhere when IRQ_KUNIT_TEST is enabled sounds rather invasive to me.

Yeah, I was leaning to 'depends on SPARSE_IRQ'

> BTW, given the test calls irq_domain_alloc_descs(), I think it should
> also depend on IRQ_DOMAIN.

Right, that's in patch 1.

I'll resend the series with a 'depends on SPARSE_IRQ'.

Thanks,
Brian

