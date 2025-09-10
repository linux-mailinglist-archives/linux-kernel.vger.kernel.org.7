Return-Path: <linux-kernel+bounces-810611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA0BB51CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F846A018B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675A32CF9D;
	Wed, 10 Sep 2025 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V2deuoGg"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800352D1911
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520356; cv=none; b=MvQJW+0726yXUViU8m+U47jXnUFCpjQ7HxheZ1oyN6Zo2GFtbvtHS5LwPts6xbe1UjLygu27VuvC2jRXy8O2aZ+oC5K+BKixfv4oSIbNXYbHdPI7l4O+5KO792f+sazSQgiiLD21WpqdLHA+RfIgOsCP0IH5QlZHtXzddl/P9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520356; c=relaxed/simple;
	bh=VYJEE0OdCF+OcIqloLm/1BOl4kW/iGjF5av4omVk19U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcNDUs/sU3tEa5VZml3E3fcRRoBGLgwt6GwD5B4pqUWV4A4pbnu1pkG8n5NbT/dKM4hF6mjOB66w6dUDW9nHKTNlConnincPNE8wIqEL+ZYlPYpWlxL43yjL3jc8gx+Vm33PD/J7gVxQLWcB67x8ocbWfQx5rv/JUFtBOXsTmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V2deuoGg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b079c13240eso73191966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757520353; x=1758125153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l7C9yj707Xq302+3n2Zc2uqWZ1bCZ56pptu3TpPal6c=;
        b=V2deuoGgxf7Z6DDbUGeCzS1bvuwH6ZdZyInyL3Z5GIVYbKoq/122X+DNYzlH9UiDIZ
         a8UczBcYzUkeDE3+BK3o10mp4cyaEj88YiCimKX+6ualbdl1c1zZNLMCkZoOLxr5E3q0
         To2Kvf1q+G/DOmYaTO5sI5DU1BppWNQ2/7fHcw1ozxgiZHzofxTrLqPRdbQKuy9yKjKk
         YqMOCn7x2/1sCCI7nQth3rqD+Gy6H5Z+QoLQRcPJFPoczYs5KnGkUDUWn6koYAGSZloV
         iRal1HSJ5dpK+GXOW/AsDfrarrxUIeqdHGzBkePfNZGv/zNqVoH+Mwqx2Mqio92Ng3Pe
         jYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520353; x=1758125153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7C9yj707Xq302+3n2Zc2uqWZ1bCZ56pptu3TpPal6c=;
        b=X1Le9ulC4T232hWsa/3gOQsB5N/UjRaR+nbySmUxkmApedoLr241Mfss4Erw/xnvNU
         UV5BWsnF5a9+3u76xwflWL5dow7dcgZapHcyV6osC6u4nFuOasYdMVh2AGf4ZfdZosQc
         T+Ht0NEaAj/fXUIGgl2vwB63SGzMoYnuMqq5kbbpP/0vKKeOpYbUtrOrkIH/PpVJnrCG
         kPT3pbUhkW910/bo++0qLj1Wv8VweS8IRGRdN5N2f7w0dgk8RYly3BG2jdgsF+MEeEA2
         m1FdEg3+EAPT6S2qB9RY1/2Kgj/pQoWxc+ODWsyXWuo4EbwkhskMDHZNPTQ/MC9/byQj
         /nAw==
X-Forwarded-Encrypted: i=1; AJvYcCVZNoA10D5wp8f8C0M4JlUYe4fh+jqKn6j5Z9NVkLZJnuVMHEQ9yX3C15gc+cToAwA6uFboFcXvhIlbE+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybz1/xoouHanwWah2EhpdnS2Gd48qghr02KvCg5XA73ALHBCDZ
	xa7iHlInoM39CkpHxhhDhN0BQrE8MCRQ5FDlTOildx9nQLZEzCSFeOMfqbcLoBqQ36o=
X-Gm-Gg: ASbGnct2VIYqrgQaFXMKyeqm+xnCTk9UEBZSic3Rzt6PXcvbCFv3p2On4o/bT8M52p1
	vtKRLBCwhCGjb5kwLVMW/LTOzf1BxpIm7LDkTHwKwCnNf+ynSMvfkbVN+xkWFtfMXFktJuxQLOW
	E+P+S8UrRH/pU2nNDaY0g8FL1AQ8MeoM+IRlL65pykTjA0wbcHm/qaqFgt84wxzXxt1imf5x32N
	yy8aaFMaNbpYWsBuABvEFkD1K+IAOVB6upZMOPion03XT+T2k2qrf120lmzWr4oeokRNLiCqnmW
	XAGBD59AGFPW3KSk6GnN9+MsfKcr1A86FafxlDSl6b1T5cgeZ4I9XaELyEdbljCBuYDyxfFULHN
	n1EFeByAvYrAtgkN41vBgrr6RJhI9ndOK13OR
X-Google-Smtp-Source: AGHT+IFYx0f6DUoknE3dgFPXDXGKuGYnSTvQRdBOTBBtYYwAndaqUysHWLmorf5AgzT60bAXrTya6w==
X-Received: by 2002:a17:907:6d0d:b0:b04:ae7c:703e with SMTP id a640c23a62f3a-b04b140a770mr1479252666b.24.1757520352091;
        Wed, 10 Sep 2025 09:05:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334d74bsm189650166b.57.2025.09.10.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:05:51 -0700 (PDT)
Date: Wed, 10 Sep 2025 18:05:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] printk: kunit: support offstack cpumask
Message-ID: <aMGh3QqB4eNsUjf5@pathway.suse.cz>
References: <20250902140326.344214-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902140326.344214-1-pmladek@suse.com>

On Tue 2025-09-02 16:03:26, Petr Mladek wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> For large values of CONFIG_NR_CPUS, the newly added kunit test fails
> to build:
> 
> kernel/printk/printk_ringbuffer_kunit_test.c: In function 'test_readerwriter':
> kernel/printk/printk_ringbuffer_kunit_test.c:279:1: error: the frame size of 1432 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
> 
> Change this to use cpumask_var_t and allocate it dynamically when
> CONFIG_CPUMASK_OFFSTACK is set.
> 
> The variable has to be released via a KUnit action wrapper so that it is
> freed when the test fails and gets aborted. The parameter type is hardcoded
> to "struct cpumask *" because the macro KUNIT_DEFINE_ACTION_WRAPPER()
> does not accept an array. But the function does nothing when
> CONFIG_CPUMASK_OFFSTACK is not set anyway.
> 
> Fixes: 5ea2bcdfbf46 ("printk: ringbuffer: Add KUnit test")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [pmladek@suse.com: Correctly handle allocation failures and freeing using KUnit test API.]
> Signed-off-by: Petr Mladek <pmladek@suse.com>

JFYI, this patch have been committed into printk/linux.git,
branch rework/ringbuffer-kunit-test.

It worked, I did it according to the feedback. Let's give
it some spin in linux-next before the next merge window.

Feel free to ask me to revert it, ...

Best Regards,
Petr

