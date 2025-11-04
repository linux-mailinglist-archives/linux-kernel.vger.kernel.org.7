Return-Path: <linux-kernel+bounces-884015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E5FC2F1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 04:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7DCE4F77EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680BA26F280;
	Tue,  4 Nov 2025 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMrcKE4v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o7nR5xVA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34526CE2C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225819; cv=none; b=QH/ZsECKo/M0ZhfyDmTmrU8n4VlXFZTb/4xl9DIurmpLVN/4TzVmy5s7wFOb3g0Qmar+QQE8QgopQXeVnqmV71CJrHGA4IH6O837UJ3JFOLsvExx2kmBjsH/EAHRXEhNNxC2vlDcqYSXtHdSqHkQCf34xh3X1Ge5W+x51kf3srQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225819; c=relaxed/simple;
	bh=DiA02NHiJ8O13whq/TwVMMOrAZYKp8grfsQGnMI6BdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q45FbQShhoeI1pvRMgGz7h2UljHCZIESMdPIXTaRDaC8GYT52Iq8pb/fAZ+uUcXX2GjFxmaKUgLI4GYvihUXKe9BRBs6YC+oDrBmOkJmUHyyc6HqCS1NU8TDebZOigMQBK8VsBoDizIrSsitoB4aIBxjtC+4F1x+JNMZpiLqLME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMrcKE4v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o7nR5xVA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762225815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZTqdWMqaOCDAV9eOD4rL4mzlFe+T9sHs56gI9JdcQ0=;
	b=QMrcKE4vCnDnsaWGB9oKlN+2NvldACYgls/PnzbMa6JWptXNlHcoFQXCHMLkwK6k40wBTa
	BGoUM7zD7Y5KTAl+F50vpcwLTJt7aFvXZOig2yQY+DkN5Z0n9KPZF1mofGiWTstbnxrJWz
	3+/eo7L4QUyzafwLdiRwe8YPD5a6+is=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-iGfvJaMSPvKC6mmYGYQ8cQ-1; Mon, 03 Nov 2025 22:10:14 -0500
X-MC-Unique: iGfvJaMSPvKC6mmYGYQ8cQ-1
X-Mimecast-MFC-AGG-ID: iGfvJaMSPvKC6mmYGYQ8cQ_1762225813
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55735710f0so9060449a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 19:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762225813; x=1762830613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZTqdWMqaOCDAV9eOD4rL4mzlFe+T9sHs56gI9JdcQ0=;
        b=o7nR5xVAP8jRFNJZ3SvcD7yir8J7lpcW6dAyiLCL5nQ9OKF183irXKyGl3xeZ97bq5
         obTsb2VPQzY4KDKez6rGM8JslnnmpBwM1Y7zMp+Sr14yclswFk2/sruAN6pUv82NgcHT
         mHsB1b0LcGwrcgfpoeGiHlhRn/360e8Z3JEUZIKl/WAW43Z7jGTfFh0Nk4Gg87Wya+zr
         MbVL8T5m3yBS7bWOx6xHg2NhGm3kL928S9XuvxtCrer9qrCDg84Ei8bmbPk+PGbVONyb
         CzV8kuXxPTMzarCzZeIjcKEAjP7ZjxgXAhdi9IV07Jk59UhOFX8a5mY3mQxhnDxk1T7N
         e6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762225813; x=1762830613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZTqdWMqaOCDAV9eOD4rL4mzlFe+T9sHs56gI9JdcQ0=;
        b=bAQGtivHXRwOlFZ52umcFTs2BmcbmCIPHZC7P6syNm2YQ9qklXOyUWxj3XOYcWzGPc
         OZWwRPU1NBYhCXiiYnXr4GqJhY8KYOOrnCQxC+HYRf1/G4WZbwnYO8WtQI8JyiKiljx3
         ntMF9unm4VW3lGVj5MxpWDiTx98Gr8A5JhVaZkQXzUJ7XbgCTqWGRPuyzUEaWLS3X/nn
         PUbMupo81ncMG/qH49lCuBtDvKYjNmJUBBsejycRs4V1l1Nl/GBii1Q2fgsgpSivGRxO
         w62WdgubBoyt1DtiVHNIR1eUX4H/S4c/Plu2TWmC2VupM7lbDnZqfsM1Vgi3faHWS+H6
         W4kw==
X-Forwarded-Encrypted: i=1; AJvYcCVS/UbKrM6lff29GOaMVTamyr8lmBGUzdoUwMIt7aTsJ/qni/Z4ojIdJKWstpBYHi7wXw3jMrxv0iihgAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdS+dm77G2xYqxP3Yvv6S/j7OoV78u9kSdsp1Rhz7KNlVp1n2m
	tAaBIChhjsUu6rLPt4ZQGy4KEJNbELNbMlddXknDuV8oF+csfy89AJoDVxU/VWmBKX7S4mTIQde
	DqUdkqsvlXBTjnDgszd6KM2mlHyiLmLMdWwaW6CgAK0xBOmS1hr5A5N8Ft7LvpGJcNQ==
X-Gm-Gg: ASbGncureAME4KluIjk8Q7ZVcgqQsDqfi6J/eoRKf8JYJePmeUlgnYnSHU6fDRm8QJr
	eIHWznWmY+/6m2euQJMZ37LP61sxQ8aN9bMFReFhAMwxBV3xdOJto71FkYBvZwaOyuurr7UczSA
	Ol+6I2eZQIchKCC5+476CbhVq/S6i9Z4rUb1Z4oCmD85b9soPv+rm0aK2cwoap6d08KrQlt0CB8
	fGtK63uTtBUDQ6hiLuHOi0xcNN0b0IxMQpy0buQY2JXvX8wk+wkz8ipShP5EKhh0mTO/CUekIPu
	hkW4itay5tFegAgWzTUh2k36qPY2mpj1Ubi8JYUglBEr8Xhqb4xm6H0SRs/aLJ9L6g==
X-Received: by 2002:a05:6a20:734c:b0:342:a7cd:9211 with SMTP id adf61e73a8af0-348cbea958dmr18363400637.34.1762225813215;
        Mon, 03 Nov 2025 19:10:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm5fBbSRyZNOxCgqY4a03dPe7CQzSGiGCw0qKW97bKKyfx2XbG2IugOoPF3SL9x4EH14/L9Q==
X-Received: by 2002:a05:6a20:734c:b0:342:a7cd:9211 with SMTP id adf61e73a8af0-348cbea958dmr18363337637.34.1762225812487;
        Mon, 03 Nov 2025 19:10:12 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f1a19e70sm635985a12.7.2025.11.03.19.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 19:10:12 -0800 (PST)
Date: Tue, 4 Nov 2025 11:05:46 +0800
From: Coiby Xu <coxu@redhat.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org, linux-integrity@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, "open list:MODULE SUPPORT" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module: Only declare set_module_sig_enforced when
 CONFIG_MODULE_SIG=y
Message-ID: <dvbgwskini45clhmqx2py46yzgwejqrna3uccempvfeip7opdq@vgfxrj46mmeq>
References: <20251031080949.2001716-1-coxu@redhat.com>
 <w4vqvjighjl33a32gvwnu7xlzmp6yztx42gbjixrhic3wt34j6@5flsq5omspn7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <w4vqvjighjl33a32gvwnu7xlzmp6yztx42gbjixrhic3wt34j6@5flsq5omspn7>

On Fri, Oct 31, 2025 at 04:09:27PM -0400, Aaron Tomlin wrote:
>On Fri, Oct 31, 2025 at 04:09:48PM +0800, Coiby Xu wrote:
>> Currently, set_module_sig_enforced is declared as long as CONFIG_MODULES
>> is enabled. This can lead to a linking error if
>> set_module_sig_enforced is called with CONFIG_MODULE_SIG=n,
>>
>>     ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
>>     security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'
>>
>> So only declare set_module_sig_enforced when CONFIG_MODULE_SIG is
>> enabled.
>>
>> Note this issue hasn't caused a real problem because all current callers
>> of set_module_sig_enforced e.g. security/integrity/ima/ima_efi.c
>> depend on CONFIG_MODULE_SIG=y.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  include/linux/module.h | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index e135cc79acee..fa251958b138 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -769,8 +769,6 @@ static inline bool is_livepatch_module(struct module *mod)
>>  #endif
>>  }
>>
>> -void set_module_sig_enforced(void);
>> -
>>  void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
>>
>>  #else /* !CONFIG_MODULES... */
>> @@ -865,10 +863,6 @@ static inline bool module_requested_async_probing(struct module *module)
>>  }
>>
>>
>> -static inline void set_module_sig_enforced(void)
>> -{
>> -}
>> -
>>  /* Dereference module function descriptor */
>>  static inline
>>  void *dereference_module_function_descriptor(struct module *mod, void *ptr)
>> @@ -924,6 +918,8 @@ static inline bool retpoline_module_ok(bool has_retpoline)
>>  #ifdef CONFIG_MODULE_SIG
>>  bool is_module_sig_enforced(void);
>>
>> +void set_module_sig_enforced(void);
>> +
>>  static inline bool module_sig_ok(struct module *module)
>>  {
>>  	return module->sig_ok;
>> @@ -934,6 +930,10 @@ static inline bool is_module_sig_enforced(void)
>>  	return false;
>>  }
>>
>> +static inline void set_module_sig_enforced(void)
>> +{
>> +}
>> +
>>  static inline bool module_sig_ok(struct module *module)
>>  {
>>  	return true;
>>
>> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
>> --
>> 2.51.0
>>
>>
>
>Looks good to me.
>
>Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

Hi Aaron,

Thanks for reviewing the patch!

>
>-- 
>Aaron Tomlin
>

-- 
Best regards,
Coiby


