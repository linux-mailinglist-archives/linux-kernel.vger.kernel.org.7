Return-Path: <linux-kernel+bounces-876791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3255C1C552
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2A61891681
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D549F271A6D;
	Wed, 29 Oct 2025 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GiChzF/f"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623322EA147
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757211; cv=none; b=r3miCNYZBxo2/WvsPNb4Dt4d7RlkiXuPeW9J0c61kylDAUdBsf1umjDUaXQl+dkDvuucN3fghb/ToeMPOm53zHf64UOE+pdcp4SooVrMH+GMDJT4d/SSlqQfgIeIJocBf+DulOqsiKZEj3lMGC8IX0npa/3dbKJO2rFRDen5KLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757211; c=relaxed/simple;
	bh=h6mfeQ3Iawf/UR9RLowS5Plb3yOeOcYnCcn+jd6alqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBqCc0dRi+PtCU6t7x4stAJlkgQtVAtmRRBwa/rpqwOXyocvHh53pm06uaqea2rb1gM94xRWKiS77lnJeYNV5q2mt5KrH1UDQoDcbeFWR2MqIWo5SxApFsEGJMmZE6wX/uQJJwE7DYm6mYqu1HiTgTIv5Ax99Z4Pp9KuQTL8WUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GiChzF/f; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475d9de970eso475775e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761757207; x=1762362007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAQZo+zCQ8BXrB42oXe87n3E1aUVEuOKQhcCU25j7Qo=;
        b=GiChzF/f1jKKxTyR0WcSFjYkdLVq8cZ3t5KJGAhGj3xXycYY+B5eyom/P5R3GGhhzN
         NrTl7ryTmwzb+Y40FNmqvpk6QFBN2QSxoqLSJMz8aBrLrMS//zfQ5IkNz1lqcAEqIWGm
         Z6c6x1lIu0qubL38Qw8hRtMHN41pau+gvKkaHuuG3nkUayqk8Do7tep/FA8Oe1o3MXOf
         bWX+XhAaK2QarUJZpgq2DVZWYKeYRalPZCVHbt7saqxwOiT+FingUmcmALuqc2B4Budf
         A4nJ8Bc9figy0pDZvNPBu+ZOVx5lUt/J3aKBoXIzt5v0H//E41bLRTvJh0eGZaIavewP
         QpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761757207; x=1762362007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAQZo+zCQ8BXrB42oXe87n3E1aUVEuOKQhcCU25j7Qo=;
        b=D4oozb7P93A9IYYI9P044VpdHwFGPA+gavoeITEDKYvpa22JJr42GVBZ6BNDmWpQKL
         9OMuviAdop1nlhvm41GSCdW3XvVGeaFXNtM5GbuFjDg1GbAapix7hv8PW7T5tBM+nNXK
         3H9I2sgzMv6jgky25h8o9/nlYhLujAdH5ywLSfZlFqdnl9DTkeob9hl2FOrcpX8cTxz+
         g2K+KFwuWLq41yoH0M5+spLUFWjrXlMSNyv5MuksyKkX0ChKSCvNsoqncKPJz3xLbTm0
         GTZMjts/kf+u4bKx1NjsTmr/uO3o7Gs7lbVhIlJF7aNFuTR1n1lipIwDfU46P5UIiL5x
         isIw==
X-Forwarded-Encrypted: i=1; AJvYcCVqAehx67u3i4bc/WPC0AzEg1b2aMewg74f8qURoBZAhDVq4m5bWPPnAdu7m9FRECQdbncZb9oS0dRYbLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVhAV5t7x9AOJDBOTVHdTM/7vKz5qq7aKWj/Yd/WECkJ6K/97v
	60ywlflU5SmegWo8zlDV7WhbomzZrMlOTeODuharA91kYG7vqO2KvnlaiP9qstUc6NjWXods6La
	0YAO5
X-Gm-Gg: ASbGncvHtfa4oxfbH1exWfJaH+/gUXLjjwU2D3LsjZqGQ164RLffs4Tphc06IM6krar
	HyFhycwcpFf2ml19YKDLVbAIYs6JPQ1ttztK46nQuq0qhz2UqgeXAtKzqM5gYvyVwFfCDjmsMpH
	FoCeyNhEdFXAqDR825L53Rws2bbr0WUoORKLyY6fYoOSUmKUX7AGkQ88ughPRXu7lMBov25uVvE
	0x6WXZyI/cjKSeQTwf8FderpGp64VGhiUbe36tj2d6ok0xJ9i3sCGa/+djYbjZvF7cWj7jqDW4E
	uYItrlVbSsOEiUcsFJduoYpvoE/0oFZLZSQC24dMX3kY6NRBG6B/5d2kIoO3axaRzn1GZQLAvj+
	drvwitE9FFTaQgM/Tzb4TDvndFK18uQ/jdIPR0zJz8SVZ4ElJskWUMSf0u+XChwY74DvIubqqrh
	C9oe+phV8w1D4GgA==
X-Google-Smtp-Source: AGHT+IHbM0ptRgn/THtFUgghTnxxazaA/YEHHDobAPcMX6nkRMmm0L2QVepzWpaw2eXFdGTXheEjNw==
X-Received: by 2002:a05:600c:3f06:b0:475:dd04:1289 with SMTP id 5b1f17b1804b1-477267cd24bmr346385e9.20.1761757206592;
        Wed, 29 Oct 2025 10:00:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47718fe63e0sm48840035e9.3.2025.10.29.10.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:00:06 -0700 (PDT)
Date: Wed, 29 Oct 2025 18:00:04 +0100
From: Petr Mladek <pmladek@suse.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <aQJIFHRMFsJ-G-ua@pathway.suse.cz>
References: <20251022154115.GA22400@redhat.com>
 <20251026150726.GA23223@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026150726.GA23223@redhat.com>

On Sun 2025-10-26 16:07:26, Oleg Nesterov wrote:
> printk_legacy_map is used to hide lock nesting violations caused by
> legacy drivers and is using the wrong override type. LD_WAIT_SLEEP is
> for always sleeping lock types such as mutex_t. LD_WAIT_CONFIG is for
> lock type which are sleeping while spinning on PREEMPT_RT such as
> spinlock_t.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

JFYI, the patch has been comitted into printk/linux.git,
branch rework/threaded-printk.

It is queued for 6.19 merge window.

Best Regards,
Petr

